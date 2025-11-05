if whence -p screen > /dev/null; then

    # Start a screen session, if screen is available, and we're not already
    # using it.
    if [ -n "$STY" ]; then
        # Screen is running, but we need to check for some specical cases,
        # e.g., a terminal emulator running inside a window system running
        # inside a screen session doesn't count.
        if [ "x${$(ps --no-headers -o cmd -p $PPID):#screen*:i}" = "x" ]; then
            # The direct parent process is screen, so we're definitely in a
            # screen session.
            true
        elif [ "x${TERM:#screen*}" != "x" ]; then
            # We assume that screen sets the TERM variable in all of its
            # subshells. So if this is not the case, we start a new session.
            exec screen -m
        fi
    else
        exec screen
    fi


    # Command for creating a new screen window with $PWD as the working
    # directory.
    function ds {
        screen zsh -c "cd \"$PWD\" && exec $SHELL --login"
    }
fi
