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

alias ls='ls --color=auto'
alias l='ls -lA'
alias ll='ls -l'
alias la='ls -A'

alias po='popd'

alias find='noglob find'
