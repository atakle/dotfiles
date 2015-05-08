# Enable parameter and command expansion in prompts.
setopt prompt_subst

# Allow each host to use a distinct colour.
if [ -z "$zsh_prompt_colour" ]; then
    zsh_prompt_colour="green"
fi

# Load vi-mode functionality.
source "$ZSH_DIR/vi-mode.zsh"

# Calling vi_mode_prompt_info will print the value of MODE_INDICATOR when in
# normal mode. Use this to make the prompt character red.
MODE_INDICATOR="%F{red}"

# Colour of the user@host string. It is red for root and $zsh_prompt_colour for
# everyone else.
local prt_colour="%B%(!.%F{red}.$F{$zsh_prompt_colour})"

# The user@host string.
local prt_userhost="%n@%m%b%f"

# Last three components of the working directory, in blue.
local prt_dir="%B%F{blue}%3~%b%f"

# The final character. It is % for users and # for root. It changes colour in
# vi normal mode.
local prt_char="\$(vi_mode_prompt_info)%#%f"

PROMPT="[$prt_color$prt_userhost $prt_dir]$prt_char "

# ZSH_THEME_GIT_PROMPT_PREFIX="("
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}✘%f"
# ZSH_THEME_GIT_PROMPT_CLEAN=" %B%F{green}✔%b%f"

# RPROMPT="\$(git_prompt_info)\${\$(battery_pct_prompt)/\\[/ [}%(1j. {%j}.)"
