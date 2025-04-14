# Example '~/.zshenv' file for bootstrapping the 'ZDOTDIR' variable.
#
# Keeping a single startup script in '$HOME' may be necessary if zsh is used as
# a login shell, and it's not possible to make changes to the system-wide
# configuration.
ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
if [[ -f "$ZDOTDIR/.zshenv" ]]; then
    . "$ZDOTDIR/.zshenv"
fi
