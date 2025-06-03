# Read environment variables from user's environment.d.
local env_d="${XDG_CONFIG_HOME:-$HOME/.config}/environment.d"
if [[ -d "$env_d" ]]; then
    setopt allexport # Export all values
    setopt null_glob # Handle empty directory

    for file in "$env_d"/*.conf; do
        source "$file"
    done

    unsetopt allexport null_glob
fi
