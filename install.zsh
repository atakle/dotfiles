#!/bin/zsh
set -e
PROGRAM="$0"
cd "$(dirname "$(readlink -f "$0")")"

# Get relevant variables.
source "$PWD/environment.d/50-xdg-dirs.conf"

# Default options
op="mklink"
dry_run="false"

function help {
    cat << EOF
Usage: $PROGRAM [-hnr]

Create symbolic links to files in the dotfiles directory.

Options:
  -h  show help
  -n  print changes, but don't actually perform them
  -r  remove links instead of creating them

Existing files will not be overwritten, neither will the -r option remove
links whose target doesn't correspond to the expected location.
EOF
}

function mklink {
    local target="$1"
    local link="$2"

    if [[ -e "$link" ]]; then
        echo "'$link' already exists; skipping."
    elif [[ "$dry_run" = "true" ]]; then
        echo "'$link' -> '$target'"
    else
        [[ -d "$(dirname "$link")" ]] || mkdir -p "$(dirname "$link")"
        ln -sv "$target" "$link"
    fi
}

function rmlink {
    local target="$1"
    local link="$2"

    if [[ ! -h "$link" ]]; then
        echo "'$link' is not a symbolic link; skipping."
    elif [[ "$(readlink -f "$link")" != "$(readlink -f "$target")" ]]; then
        echo "'$link' points to a different target; skipping."
    elif [[ "$dry_run" = "true" ]]; then
        echo "removed '$link'"
    else
        rm -v "$link"
    fi
}

function run {
    $op "$PWD/environment.d/50-xdg-dirs.conf" \
        "$XDG_CONFIG_HOME/environment.d/50-xdg-dirs.conf"

    $op "$PWD/gitconfig" "$XDG_CONFIG_HOME/git/config"
    $op "$PWD/lesskey" "$XDG_CONFIG_HOME/lesskey"
    $op "$PWD/vim" "$XDG_CONFIG_HOME/vim"

    $op "$PWD/editrc" "$EDITRC"
    $op "$PWD/inputrc" "$INPUTRC"
    $op "$PWD/screenrc" "$SCREENRC"
    $op "$PWD/xcompose" "$XCOMPOSEFILE"


    if [[ -z "$ZDOTDIR" ]]; then
        ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
        echo "Warn: 'ZDOTDIR' is not set; using '$ZDOTDIR'"
    fi
    $op "$PWD/zsh" "$ZDOTDIR"
}

function args {
    while getopts ':hnr' arg; do
        case "$arg" in
            h)
                help
                exit 0
                ;;
            n)
                dry_run="true"
                ;;
            r)
                op="rmlink"
                ;;
            ?)
                echo "$PROGRAM: bad option: -$OPTARG" 1>&2
                exit 1
                ;;
        esac
    done
}

args "$@"
run
