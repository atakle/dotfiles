autoload -Uz vcs_info

# Which version control systems to support.
zstyle ':vcs_info:*' enable git

# Check for changed files. Might be slow for large repos.
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:*' formats       '(%b%c%u)'
zstyle ':vcs_info:*' actionformats '(%b%c%u %a)'

# Get list of unapplied patches.
zstyle ':vcs_info:*' get-unapplied true

# Modify the %c and %u strings to display the number of staged changes,
# unstaged changes and untracked files.
function +vi-git-countformat() {
    # Display formats for the git status. The `0' will be replaced by the
    # corresponding number of files or commits.
    local prt_git_s=" %{%F{green}%}+0%{%f%}"   # Staged files.
    local prt_git_m=" %{%F{yellow}%}x0%{%f%}"  # Unstaged modifications.
    local prt_git_c=" %{%B%F{red}%}!0%{%b%f%}" # Files with conflicts.
    local prt_git_u=" %{%F{magenta}%}?0%{%f%}" # Untracked files.
    local prt_git_a=" %{%F{green}%}→0%{%f%}"   # Commits ahead of origin.
    local prt_git_b=" %{%F{red}%}←0%{%f%}"     # Commits behind origin.

    local -a changes
    # Parse the git status output and assign the result to `changes'.
    changes=($(
        git status -bs --porcelain |
        awk '/^##.*ahead/  {a=$4}        # a: commits ahead
             /^##.*behind/ {b=$4}        # b: commits behind
             /^##.*,/      {a=$4; b=$6}  # s: staged files
             /^A/          {s++}         # m: modifications
             /^M/          {s++}         # c: conflicts
             /^R/          {s++}         # u: untracked files
             /^D/          {s++}
             /^.M/         {m++}
             /^.A/         {m++}
             /^.D/         {m++}
             /^(U.|.U)/    {c++}
             /^.?\?/       {u++}
             # Add 0 to make nonempty and coerce to numbers.
             END { print s+0, m+0, c+0, u+0, a+0, b+0}'))
    hook_com[staged]=""
    hook_com[unstaged]=""
    [[ ${changes[1]} != "0" ]] &&
        hook_com[staged]="${prt_git_s/0/${changes[1]}}"
    [[ ${changes[2]} != "0" ]] &&
        hook_com[unstaged]+="${prt_git_m/0/${changes[2]}}"
    [[ ${changes[3]} != "0" ]] &&
        hook_com[unstaged]+="${prt_git_c/0/${changes[3]}}"
    [[ ${changes[4]} != "0" ]] &&
        hook_com[unstaged]+="${prt_git_u/0/${changes[4]}}"

    if [ -z "${hook_com[unstaged]}${hook_com[staged]}" ]; then
        # exploit the `staged' variable to indicate a clean repository.
        hook_com[staged]=" %{%B%F{green}%}✔%{%b%f%}"
    fi

    [[ ${changes[5]} != "0" ]] &&
        hook_com[unstaged]+=${prt_git_a/0/${changes[5]}}
    [[ ${changes[6]} != "0" ]] &&
        hook_com[unstaged]+=${prt_git_b/0/${changes[6]}}

}

# Run the countformat function before returning the message.
zstyle ':vcs_info:git*+set-message:*' hooks git-countformat
