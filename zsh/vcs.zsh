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
    # Display formats for staged, modified, conflicted and untracked files,
    # respectively. The `0' will be replaced by the corresponding number of
    # files.
    local prt_git_s=" %{%F{green}%}+0%{%f%}"
    local prt_git_m=" %{%F{yellow}%}x0%{%f%}"
    local prt_git_c=" %{%B%F{red}%}!0%{%b%f%}"
    local prt_git_u=" %{%F{magenta}%}?0%{%f%}"
    local prt_git_a=" %{%F{green}%}→0%{%f%}"
    local prt_git_b=" %{%F{red}%}←0%{%f%}"

    local -a changes
    # Parse the git status output and assign to `changes' an array of four
    # elements, containing the number of staged, modified, conflicted, and
    # untracked files, respectively.
    changes=($(
        git status -bs --porcelain |
        awk '/^##.*ahead/  {a=$4}
             /^##.*behind/ {b=$4}
             /^##.*,/  {a=$4; b=$6}
             /^A/    {s+=1}
             /^M/    {s+=1}
             /^D/    {s+=1}
             /^.M/   {m+=1}
             /^.A/   {m+=1}
             /^.D/   {m+=1}
             /^U./   {c+=1}
             /^.U/   {c+=1}
             /^.?\?/ {u+=1}
             # Add 0 to make nonempty and coerce to numbers.
             END { print s+0, m+0, c+0, u+0, a+0, b+0}'))
    hook_com[staged]=""
    hook_com[unstaged]=""
    test ${changes[1]} != "0" &&
        hook_com[staged]="${prt_git_s/0/${changes[1]}}"
    test ${changes[2]} != "0" &&
        hook_com[unstaged]+="${prt_git_m/0/${changes[2]}}"
    test ${changes[3]} != "0" &&
        hook_com[unstaged]+="${prt_git_c/0/${changes[3]}}"
    test ${changes[4]} != "0" &&
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
