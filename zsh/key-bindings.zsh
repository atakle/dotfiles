bindkey -v

# More time to type composite commands
export KEYTIMEOUT=100

bindkey "jk"    "vi-cmd-mode"
bindkey "[1~" "beginning-of-line"    # HOME
bindkey "[4~" "end-of-line"          # END
bindkey "^H"    "backward-delete-char" # BACKSPACE

bindkey -a "u"  "undo"
bindkey -a "^R" "redo"

autoload -Uz edit-command-line
bindkey -a "V" edit-command-line

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
