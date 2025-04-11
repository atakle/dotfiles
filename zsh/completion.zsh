setopt complete_in_word # Don't move the cursor to the end of the word before
                        # completing.

setopt auto_menu # Use a menu after the second request for completion.

# Which completers to try, in order.
zstyle ':completion:*' completer                                      \
    _complete    `: Normal completion.`                               \
    _match       `: Match using the patterns in 'matcher-list'`       \
    _approximate `: Similar to _complete, but with error correction.`

# The matches to try with the _match completer.
zstyle ':completion:*' matcher-list \
     ''                             \
     'l:|=*       r:|=*'            \
     'm:{[:lower:]}={[:upper:]}'    \
    '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Try running _match without an * at the cursor position first, and add the *
# if that doesn't work.
zstyle ':completion:*' match-original both

# Allow at most two errors with the _approximate completer.
zstyle ':completion:*' max-errors 2

# Start menu selection if the matches list doesn't fit on the screen.
zstyle ':completion:*' menu select=long

# Start the completion system.
autoload -U compinit
compinit -d "$ZDOTDIR/zcompdump"

autoload -U bashcompinit
bashcompinit
