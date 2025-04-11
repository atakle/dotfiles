bindkey -v

# More time to type composite commands
export KEYTIMEOUT=100

# Some extra functionality
autoload -Uz edit-command-line
autoload -Uz modify-current-argument

bindkey "jk"    vi-cmd-mode
bindkey "[1~" beginning-of-line    # HOME
bindkey "[4~" end-of-line          # END
bindkey "^H"    backward-delete-char # BACKSPACE
bindkey "[3~" delete-char          # DELETE

# Upper-case the word to the left of the cursor.
function viins-uppercase() {
    zle vi-cmd-mode
    zle vi-backward-word
    zle up-case-word
    zle vi-add-next
}
zle -N viins-uppercase

bindkey "^U" viins-uppercase

bindkey -a "u"  "undo"
bindkey -a "^R" "redo"

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

bindkey -a "V" edit-command-line

bindkey -a "[3~" vi-delete-char

# Upper-case the argument under the cursor
function vicmd-upcase() {
    modify-current-argument '${ARG:u}'
}
zle -N vicmd-upcase
bindkey -a "gU" vicmd-upcase

# Lower-case the argument under the cursor
function vicmd-lowcase() {
    modify-current-argument '${ARG:l}'
}
zle -N vicmd-lowcase
bindkey -a "gu" vicmd-lowcase


# Emulate the change/delete inside/around symbol operations from vim. Will
# behave oddly if not used inside a pair of symbols.
function bind_vim_motion () {
    bindkey -as "ci${1}" "F${2}lct${3}"
    bindkey -as "ca${1}" "F${2}cf${3}"
    bindkey -as "di${1}" "F${2}ldt${3}"
    bindkey -as "da${1}" "F${2}df${3}"
}

bind_vim_motion "(" "(" ")"
bind_vim_motion ")" "(" ")"
bind_vim_motion "\"" "\"" "\""
bind_vim_motion "\`" "\`" "\`"
bind_vim_motion "'" "'" "'"
bind_vim_motion "{" "{" "}"
bind_vim_motion "}" "{" "}"
bind_vim_motion "[" "[" "]"
bind_vim_motion "]" "[" "]"

# Poorly emulates the vim command to change/delete the word under the cursor.
# On one-letter words, use s instead.
bindkey -as "ciw" "lbce"
bindkey -as "caw" "lbdes"
bindkey -as "ciW" "lBcE"
bindkey -as "caW" "lBdEs"
bindkey -as "diw" "lbde"
bindkey -as "daw" "lbdex"
bindkey -as "diW" "lBdE"
bindkey -as "daW" "lBdEx"

# Disable flow control (^S/^Q)
stty -ixon
