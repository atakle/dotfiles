if [[ -z "$ZDOTDIR" ]]; then
    echo "ZDOTDIR is not defined. Skipping zshrc scripts" 1>&2
    return 1
fi

for file in "$ZDOTDIR"/zshrc.d/*; do
    . "$file"
done
