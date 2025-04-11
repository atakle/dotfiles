export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

if [ -d "$HOME/.local/bin" ]; then
    path=("$HOME/.local/bin" $path)
    typeset -U path PATH
fi

# Make sure the XDG base directories are defined

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_DATA_HOME:-$HOME/.local/state}"

# Configuration file overrides

export EDITRC="$XDG_CONFIG_HOME/editrc"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export SCREENRC="$XDG_CONFIG_HOME/screenrc"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/XCompose"
# ZDOTDIR needs to be set earlier
