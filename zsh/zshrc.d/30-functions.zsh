# Create a new screen window with $PWD as the working directory
if whence -p screen > /dev/null; then
    function ds {
        screen zsh -c "cd \"$PWD\" && exec $SHELL --login"
    }
fi

# Open an address in (a new tab in) konqueror
if whence -p kfmclient > /dev/null; then
    function kq {
        if [ -z "$*" ]; then
            kfmclient openURL .
        else
            kfmclient openURL "$*"
        fi
    }
fi
