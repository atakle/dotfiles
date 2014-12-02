# First try case sensitive matching. If that doesn't match anything, try
# case insensitive matching.
zstyle ':completion:*' matcher-list \
    ''                              \
    'm:{a-zA-Z}={A-Za-z}'           \
    'r:|[._-]=* r:|=*'              \
    'l:|=* r:|=*'
