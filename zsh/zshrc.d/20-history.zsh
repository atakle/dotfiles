if [ -z "$HISTFILE" ]; then
    HISTFILE=$ZDOTDIR/zsh_history
fi

HISTSIZE=50000 # Maximum history size.
SAVEHIST=10000 # Maximun number of entries to add from a single session.

setopt append_history         # Don't truncate an existing file.
setopt hist_expire_dups_first # Replace duplicate commands first.
setopt hist_ignore_dups       # Don't add consecutive duplicate commands.
