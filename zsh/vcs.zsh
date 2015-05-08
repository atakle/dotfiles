autoload -Uz vcs_info

precmd() {
    vcs_info
}

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
    # Display formats for staged, modified and untracked files, respectively.
    # The `0' will be replaced by the corresponding number of files.
    local prt_git_s=" %B%F{green}+0%b%f"
    local prt_git_m=" %F{yellow}x0%f"
    local prt_git_u=" %B%F{yellow}?0%b%f"

    # Run only if the repository is dirty.
    if [ -n "${hook_com[unstaged]}${hook_com[staged]}" ]; then
        local -a changes
        # Parse the git status output and assign to `changes' an array of three
        # elements, containing the number of staged, modified, and untracked
        # files, respectively.
        changes=($(
            git status -s --porcelain |
            awk '/^A/    {a+=1}
                 /^M/    {a+=1}
                 /^D/    {a+=1}
                 /^.M/   {m+=1}
                 /^.A/   {m+=1}
                 /^.D/   {m+=1}
                 /^.?\?/ {u+=1}
                 END { print a+0, m+0, u+0 }'))
        hook_com[unstaged]=""
        test ${changes[1]} != "0" &&
            hook_com[staged]="${prt_git_s/0/${changes[1]}}"
        test ${changes[2]} != "0" &&
            hook_com[unstaged]+="${prt_git_m/0/${changes[2]}}"
        test ${changes[3]} != "0" &&
            hook_com[unstaged]+="${prt_git_u/0/${changes[3]}}"
    else
        # exploit the `staged' variable to indicate a clean repository.
        hook_com[staged]=" %B%F{green}✔%b%f"
    fi
}

# Run the countformat function before returning the message.
zstyle ':vcs_info:git*+set-message:*' hooks git-countformat
