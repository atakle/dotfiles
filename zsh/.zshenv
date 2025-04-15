export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Try to prevent programs from polluting the home directory.

export EDITRC="$XDG_CONFIG_HOME/editrc"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export SCREENDIR="$XDG_RUNTIME_DIR/screen"
export SCREENRC="$XDG_CONFIG_HOME/screenrc"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/XCompose"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export MAVEN_OPTS="-Dmaven.repo.local=$XDG_DATA_HOME/maven/repository"

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"


# Add ~/.local/bin to PATH, if it exists.
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
    typeset -U path PATH
fi

export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
