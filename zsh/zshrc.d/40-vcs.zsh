autoload -Uz vcs_info

# Which version control systems to support.
zstyle ':vcs_info:*' enable git

# Check for changed files. Might be slow for large repos.
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:*' formats       '(%b%m)'
zstyle ':vcs_info:*' actionformats '(%b%m %a)'

# Get list of unapplied patches.
zstyle ':vcs_info:*' get-unapplied true

# Populate the %m (misc) part of the prompt with custom information.
function +vi-git-countformat() {
    # Check if we're in a bare repository, or inside the .git directory, since
    # Calling 'git status' only works from inside a work tree.
    if [[ "$(git rev-parse --is-inside-work-tree)" = "false" ]]; then
        if [[ "$(git rev-parse --is-bare-repository)" = "true" ]]; then
            hook_com[misc]=" bare"
        else
            hook_com[misc]=" .git"
        fi
        return
    fi

    local -a changes
    changes=($(git status --branch --porcelain | awk \
       '/^##.*ahead/  { ahead=$4 }
        /^##.*behind/ { behind=$4 }
        /^##.*,/      { ahead=$4; behind=$6 }
        /^A/          { staged++ }
        /^M/          { staged++ }
        /^R/          { staged++ }
        /^D/          { staged++ }
        /^.M/         { modified++ }
        /^.A/         { modified++ }
        /^.D/         { modified++ }
        /^(U.|.U)/    { conflicts++ }
        /^\?\?/       { untracked++ }
        END {
            # Add 0 to make nonempty and coerce to numbers.
            print staged+0, modified+0, conflicts+0, untracked+0,
                  ahead+0, behind+0
        }'))

    local staged=${changes[1]}
    local modified=${changes[2]}
    local conflicts=${changes[3]}
    local untracked=${changes[4]}
    local ahead=${changes[5]}
    local behind=${changes[6]}

    local msg=""
    [[ "$staged" != "0" ]] && msg+=" %{%F{green}%}+$staged%{%f%}"
    [[ "$modified" != "0" ]] && msg+=" %{%F{yellow}%}x$modified%{%f%}"
    [[ "$conflicts" != "0" ]] && msg+=" %{%B%F{red}%}!$conflicts%{%b%f%}"
    [[ "$untracked" != "0" ]] && msg+=" %{%F{magenta}%}?$untracked%{%f%}"
    [[ "$ahead" != "0" ]] && msg+=" %{%F{green}%}→$ahead%{%f%}"
    [[ "$behind" != "0" ]] && msg+=" %{%F{red}%}←$behind%{%f%}"

    hook_com[misc]="$msg"
}

# Run the countformat function before returning the message.
zstyle ':vcs_info:git*+set-message:*' hooks git-countformat
