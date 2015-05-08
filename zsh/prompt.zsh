# Allow each host to use a distinct colour
if [ -z "$zsh_prompt_colour" ]; then
    zsh_prompt_colour="green"
fi

# Split up the prompt definition.
local prompt_userhost="%B%(!.%F{red}.%F{$zsh_prompt_colour})%n@%m%b%f"
local prompt_dir="%B%F{blue}%3~%b%f"
local prompt_char="\$(vi_mode_prompt_info)%#%f"

# Vi normal mode changes the colour of $prompt_char.
# MODE_INDICATOR="%F{red}"

PROMPT="[$prompt_userhost $prompt_dir]%# "

# ZSH_THEME_GIT_PROMPT_PREFIX="("
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}✘%f"
# ZSH_THEME_GIT_PROMPT_CLEAN=" %B%F{green}✔%b%f"

# RPROMPT="\$(git_prompt_info)\${\$(battery_pct_prompt)/\\[/ [}%(1j. {%j}.)"
RPROMPT="%(1j. {%j}.)"
