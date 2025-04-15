autoload -Uz vcs_info

# Which version control systems to support.
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:*' formats       '(%b%m)'
zstyle ':vcs_info:*' actionformats '(%b%m %a)'

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

    git status --branch --porcelain | awk \
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
        }' \
    | read staged modified conflicts untracked ahead behind

    local msg=""
    [[ "$staged" != "0" ]] && msg+=" %{%F{green}%}+$staged%{%f%}"
    [[ "$modified" != "0" ]] && msg+=" %{%F{yellow}%}x$modified%{%f%}"
    [[ "$conflicts" != "0" ]] && msg+=" %{%B%F{red}%}!$conflicts%{%b%f%}"
    [[ "$untracked" != "0" ]] && msg+=" %{%F{magenta}%}?$untracked%{%f%}"
    [[ "$ahead" != "0" ]] && msg+=" %{%F{green}%}→$ahead%{%f%}"
    [[ "$behind" != "0" ]] && msg+=" %{%F{red}%}←$behind%{%f%}"

    [[ -z "$msg" ]] && msg=" %{%B%F{green}%}✔%{%b%f%}"
    hook_com[misc]="$msg"
}

# Run the countformat function before returning the message.
zstyle ':vcs_info:git*+set-message:*' hooks git-countformat
