# Example '/etc/zsh/zshenv' file.

if [[ -o "rcs" && -z "$ZDOTDIR" ]]
then
    # Allow users to put zsh configuration in '$XDG_CONFIG_HOME/zsh', instead
    # of directly in '$HOME'. The 'ZDOTDIR' variable will be set to this
    # directory only if it already contains at least one of the zsh startup
    # scripts, so it should not affect users who don't want this behaviour.
    local xdg_zsh="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
    if [[ -f "$xdg_zsh/.zshenv" \
       || -f "$xdg_zsh/.zprofile" \
       || -f "$xdg_zsh/.zshrc" \
       || -f "$xdg_zsh/.zlogin" \
       || -f "$xdg_zsh/.zlogout" ]]
    then
        ZDOTDIR="$xdg_zsh"
    fi
fi
