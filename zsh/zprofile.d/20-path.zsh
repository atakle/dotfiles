# Add ~/.local/bin to PATH, if it exists.
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
    typeset -U path PATH
fi
