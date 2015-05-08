if [ -z "$HISTFILE" ]; then
    HISTFILE=$ZSH_DIR/zsh_history
fi

HISTSIZE=50000

setopt append_history
setopt extended_history
setopt hist_ignore_dups
