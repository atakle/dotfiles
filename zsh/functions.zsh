# Create a new screen window with $PWD as the working directory
if [ -x "/usr/bin/screen" ]; then
    function ds {
        screen zsh -c "cd \"$PWD\" && exec $SHELL --login"
    }
fi

# Open an address in (a new tab in) konqueror
if [ -x "/usr/bin/kfmclient" ]; then
    function kq {
        if [ -z "$*" ]; then
            kfmclient openURL .
        else
            kfmclient openURL "$*"
        fi
    }
fi
