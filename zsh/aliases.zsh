alias vi='vim'
compdef _vim vi=vim

# Coloured diffs
whence -p colordiff > /dev/null && \
    alias diff='colordiff'

# Coloured pacman output, and some shortcuts
if [ -x /usr/bin/pacman ]; then
    alias pacman='pacman --color auto'
    alias syu='sudo pacman -Syu'
    alias pss='pacman -Ss'
fi

alias la="ls -A"
alias find="noglob find"

# vimdiff with root privileges
alias sudodiff="env EDITOR=vimdiff sudo -e"
