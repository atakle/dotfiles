# Enable parameter and command expansion in prompts.
setopt prompt_subst

# Add some additional functionality.
source "$ZSH_DIR/battery.zsh"
source "$ZSH_DIR/vcs.zsh"
source "$ZSH_DIR/vi-mode.zsh"

# Calling `vi_mode_prompt_info' will print the value of MODE_INDICATOR when in
# normal mode. This is used to make the shell state character red.
MODE_INDICATOR="%F{red}"

# Construct the left part of the prompt. The definition is split into pieces for
# legibility.
_left_prompt() {
    # Working directory
    local working_dir_full="%~"
    # Showing only the first two (%-2~) and the last two (%2~) segments. We're
    # also removing the bold colouring from the '...' in between, so it stands
    # out a little.
    local working_dir_truncated="%-2~/%{%b%}...%{%B%}/%2~"
    # Use truncated path if it's five or more segments long:
    local working_dir_txt="%(5~|$working_dir_truncated|$working_dir_full)"
    local working_dir="%{%B%F{blue}%}${working_dir_txt}%{%b%f%}"

    # Username and hostname
    local user_host_txt="%n@%m"
    # Displayed in red if running as root:
    local colour_root="%{%B%F{red}%}"
    # Or in whatever colour is defined by 'zsh_prompt_colour' if running as a
    # regular user; green by default:
    local colour_user="%{\${zsh_prompt_colour:-%B%F{green}}%}"
    # Colour depends on whether the shell is running with privileges:
    local user_host="%(!|$colour_root|$colour_user)$user_host_txt%{%b%f%}"

    # Return status of the previous command
    local return_status_txt="%?"
    local return_status_colour="(%{%F{red}%}$return_status_txt%{%f%}%) "
     # Show only if nonzero:
    local return_status="%(0?||$return_status_colour)"

    # Shell state (the final character), displayed as '#' if running with
    # privileges, and '%' otherwise:
    local shell_state_txt="%#"
    # The vi mode is indicated by changing the colour of the shell state
    # character, using the sequence defined in 'MODE_INDICATOR' above.
    local shell_state="%{\$(vi_mode_prompt_info)%}$shell_state_txt%{%b%f%}"

    # Full prompt: '(1) [username@hostname /usr/share/example]% '
    echo "${return_status}[${user_host} ${working_dir}]${shell_state} "
}

# Construct the right part of the prompt.
_right_prompt() {
    # Basename (tail) of the Python virtualenv directory:
    local python_virtualenv_txt="(\${VIRTUAL_ENV:t})"
    # Or an empty string if no virtualenv is in use:
    local python_virtualenv="\${VIRTUAL_ENV:+$python_virtualenv_txt}"

    # Version control information is read from the 'vcs_info_msg_0_' variable.
    # The display format is defined in 'vcs.zsh'.
    local version_control="\${vcs_info_msg_0_}"

    # Battery status display is defined in 'battery.zsh'.
    local battery="\$(prompt_battery)"

    # Number of background jobs
    background_jobs_txt=" {%j}"
    # Display only if at least one:
    background_jobs="%(1j|$background_jobs_txt|)"

    echo "${python_virtualenv}${version_control}${battery}${background_jobs}"
}

PROMPT="$(_left_prompt)"
RPROMPT="$(_right_prompt)"

# These are no longer needed:
unfunction _left_prompt _right_prompt

# Update version control info before rendering the prompt.
precmd() {
    vcs_info
}

# Prevent the display of child processes from going blank when a child process
# ends, while still taking up space.
TRAPCHLD() {
    [[ -o notify ]] && zle && { zle reset-prompt; zle -R }
}
