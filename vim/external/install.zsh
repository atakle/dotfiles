#!/bin/zsh
# Download and install vim plugins and themes created by other people.
#
# The following dependencies are used:
# - vim-commentary, by Tim Pope (https://github.com/tpope/vim-commentary)
# - vim-repeat, by Tim Pope (https://github.com/tpope/vim-commentary)
# - vim-surround, by Tim Pope (https://github.com/tpope/vim-surround)
# - herald colour scheme, by Fabio Cevasco (https://h3rald.com/herald-vim-color-scheme/)
set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

VIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/vim"
if [[ ! -f "$VIM_DIR/vimrc" ]]; then
  echo "$VIM_DIR: not the vim directory?" 1>&2
  exit 1
fi

DOWNLOAD_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/vim/plugins"

function download {
  curl \
    --location \
    --create-dirs \
    --output-dir "$DOWNLOAD_DIR" \
    --skip-existing \
    "https://github.com/tpope/vim-commentary/archive/refs/tags/v1.3.tar.gz" \
    --output "vim-commentary-1.3.tar.gz" \
    "https://github.com/tpope/vim-repeat/archive/refs/tags/v1.2.tar.gz" \
    --output "vim-repeat-1.2.tar.gz" \
    "https://github.com/tpope/vim-surround/archive/refs/tags/v2.2.tar.gz" \
    --output "vim-surround-2.2.tar.gz" \
    "https://github.com/vim-scripts/herald.vim/archive/refs/tags/0.2.0.tar.gz" \
    --output "herald.vim-0.2.0.tar.gz"
}

function verify {
  local checksum_file="$SCRIPT_DIR/sha256sums"

  cd "$DOWNLOAD_DIR"
  sha256sum --check < "$checksum_file"
}

function install_plugins {
  local install_dir="$VIM_DIR/pack/editing/start"
  [[ -d "$install_dir" ]] || mkdir -p "$install_dir"

  local plugins=(
    "vim-repeat-1.2.tar.gz"
    "vim-surround-2.2.tar.gz"
    "vim-commentary-1.3.tar.gz"
  )

  for file in "${plugins[@]}"; do
    tar \
      --extract \
      --directory "$install_dir" \
      --file "$DOWNLOAD_DIR/$file"
  done
}

function install_theme {
  tar \
    --extract \
    --directory "$VIM_DIR" \
    --strip-components 1 \
    --file "$DOWNLOAD_DIR/herald.vim-0.2.0.tar.gz" \
    "herald.vim-0.2.0/colors/herald.vim"

  # Apply custom changes
  patch \
      --directory "$VIM_DIR/colors" \
      --strip 1 \
      < "$SCRIPT_DIR/herald.patch"
}

download
verify
install_plugins
install_theme
