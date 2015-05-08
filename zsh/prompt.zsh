# Enable parameter and command expansion in prompts.
setopt prompt_subst

# Allow each host to use a distinct colour.
if [ -z "$zsh_prompt_colour" ]; then
    zsh_prompt_colour="green"
fi

# Add some additional functionality.
source "$ZSH_DIR/battery.zsh"
source "$ZSH_DIR/vcs.zsh"
source "$ZSH_DIR/vi-mode.zsh"

# Calling vi_mode_prompt_info will print the value of MODE_INDICATOR when in
# normal mode. Use this to make the prompt character red.
MODE_INDICATOR="%F{red}"

# Colour of the user@host string. It is red for root and $zsh_prompt_colour for
# everyone else.
local prt_colour="%B%(!.%F{red}.%F{$zsh_prompt_colour})"

# The user@host string.
local prt_userhost="%n@%m%b%f"

# Last three components of the working directory, in blue.
local prt_dir="%B%F{blue}%3~%b%f"

# The final character. It is % for users and # for root. It changes colour in
# vi normal mode.
local prt_char="\$(vi_mode_prompt_info)%#%f"

PROMPT="[$prt_colour$prt_userhost $prt_dir]$prt_char "

local prt_bat="\$(prompt_battery)"  # Battery indicator.
local prt_jobs="%(1j. {%j}.)"       # Number of background jobs, if any.
local prt_vcs="\${vcs_info_msg_0_}" # Version control info.

RPROMPT="${prt_vcs}${prt_bat}${prt_jobs}"
