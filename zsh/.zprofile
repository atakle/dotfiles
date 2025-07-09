if [[ -z "$ZDOTDIR" ]]; then
    echo "ZDOTDIR is not defined. Skipping zprofile scripts" 1>&2
    return 1
fi

for file in "$ZDOTDIR"/zprofile.d/*; do
    . "$file"
done
