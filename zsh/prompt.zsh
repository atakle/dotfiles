# Enable parameter and command expansion in prompts.
setopt prompt_subst

# Allow each host to use a distinct colour.
if [ -z "$zsh_prompt_colour" ]; then
    # Green by default.
    zsh_prompt_colour="%B%F{green}"
fi

# Add some additional functionality.
source "$ZSH_DIR/battery.zsh"
source "$ZSH_DIR/vcs.zsh"
source "$ZSH_DIR/vi-mode.zsh"

# Calling `vi_mode_prompt_info' will print the value of MODE_INDICATOR when in
# normal mode. Use this to make the prompt character red.
MODE_INDICATOR="%F{red}"

# Components that don't need to be updated:

local prt_user="%n@%m" # The user@host string.
local prt_dir="%~"     # Current working directory.
local prt_char="%#"    # The final character, % for users and # for root.

# Versions of the above with colour added. These are defined separately,
# because they make it hard to compute the length of the prompt.
local col_user="%(!.%{%B%F{red}%}.%{$zsh_prompt_colour%})$prt_user%{%b%f%}"
local col_dir="%{%B%F{blue}%}$prt_dir%{%f%b%}"
local col_char="%{\$(vi_mode_prompt_info)%}$prt_char%{%b%f%}"

local prt_jobs="%(1j. {%j}.)" # Number of background jobs, if any.

# Return status of the last command in red, if it was nonzero.
local col_ret="%(0?..(%{%F{red}%}%?%{%f%}%) )"

# Expression that matches all non-visible character sequences.
local zero='%([BSUbfksu]|([FB]|){*})'

# Prevent $prt_jobs from going blank when a child process ends, while still
# taking up space.
TRAPCHLD() {
    [[ -o notify ]] && zle && { zle reset-prompt; zle -R }
}

# The precmd() function is called every time before the prompt appears.
precmd() {
    vcs_info # Update VCS information. # This sets the value of
             # $vcs_info_msg_0_.
    local col_vcs="${vcs_info_msg_0_}"

    # Update the battery indicator.
    local col_bat="$(prompt_battery)"


    local termwidth=$((COLUMNS))          # Total available space.
    local threshold=$((0.48 * termwidth)) # Threshold for switching to a
                                          # multi-line prompt.

    # Compute the length of the components.
    local dlen llen blen vlen rlen;
    dlen=${#:-(${(%)prt_dir})}                    # Path.
    (( llen = ${#:-[${(%)prt_user} ]# } + dlen )) # Left prompt.

    blen=${#${(S%%)col_bat//$~zero/}}             # Battery
    vlen=${#${(S%%)col_vcs//$~zero/}}             # Version control.
    (( rlen = ${#${(%)prt_jobs}} + vlen + blen )) # Right prompt.

    # Check if we can put everything on a single line.
    if [[ $((llen <= threshold && rlen <= threshold)) -ne 0 ]]; then
        PROMPT="${col_ret}[$col_user $col_dir]$col_char "
        RPROMPT="$col_vcs$col_bat$prt_jobs"
        return
    fi

    # We have a multi-line prompt. The contents of RPROMPT would have been
    # placed on the same line as the last character in PROMPT, so we add its
    # contents to PROMPT instead, after some padding.
    unset RPROMPT

    # This will be the left part of the second line.
    local snd_prt="
${col_ret}[$col_user]$col_char "


    # Put PWD and what used to be RPROMPT on the same line as long as it has
    # space for both.
    if [[ $(((dlen + rlen) < termwidth)) -ne 0 ]]; then
        # Add the path specifier to the prompt.
        PROMPT="($col_dir)"

        # Distance between the left and right sides.
        local pad=$((termwidth - (dlen + rlen)))

        PROMPT+="%{%B%F{black}%}${(l:((pad))::-:):-}%{%b%f%}"
        PROMPT+="$col_vcs$col_bat$prt_jobs"
        PROMPT+="$snd_prt"
    fi
}
