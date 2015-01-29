export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# Add the user's bin folder to PATH if it exists and is not already there.
if [ -d "$HOME/bin" ]; then
    case :$PATH: in
        *:$HOME/bin:*) ;; # Already present
        *) PATH="$HOME/bin:$PATH"
    esac
fi

# Do the same with MANPATH.
if [ -d "$HOME/share/man" ]; then
    case :$MANPATH: in
        *:$HOME/share/man:*) ;; # Already present
        *) MANPATH="$HOME/share/man:$MANPATH"
    esac
fi
