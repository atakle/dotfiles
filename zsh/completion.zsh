# Start the completion system.
autoload -U compinit
compinit

setopt complete_in_word
setopt auto_menu

# First try case sensitive matching. If that doesn't match anything, try
# case insensitive matching.
zstyle ':completion:*' matcher-list \
    ''                              \
    'r:|[._-]=* r:|=*'              \
    'l:|=* r:|=*'                   \
    'm:{a-zA-Z}={A-Za-z}'
