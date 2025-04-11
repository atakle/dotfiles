# Try to prevent programs from polluting the home directory.

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

export EDITRC="$XDG_CONFIG_HOME/editrc"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export SCREENRC="$XDG_CONFIG_HOME/screenrc"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/XCompose"


# Put user executables in ~/.bin

if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
    typeset -U path PATH
fi

export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
