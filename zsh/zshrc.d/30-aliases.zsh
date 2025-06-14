alias vi='vim'
compdef _vim vi=vim

# Coloured diffs
whence -p colordiff > /dev/null && \
    alias diff='colordiff'

# Coloured pacman output, and some shortcuts
if whence -p pacman > /dev/null; then
    alias pacman='pacman --color auto'
    alias syu='sudo pacman -Syu'
    alias pss='pacman -Ss'
fi

# Remove the `screen.' prefix from TERM when using ssh
alias ssh='TERM=${TERM#screen.} ssh'

alias ls='ls --classify=auto --color=auto'
alias l='ls -lA'
alias ll='ls -l'
alias la='ls -A'

whence -p tree > /dev/null && \
    alias tree='tree -F'

alias po='popd'

alias find='noglob find'
alias git='noglob git'

alias rm='rm -I'

# This happens way too often
alias gti=git
compdef _git gti=git

# Make wtf honest
whence -p wtf >/dev/null && \
    alias wtf='wtf -o'

alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
