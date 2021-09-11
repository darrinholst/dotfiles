#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "$0")" ; pwd -P )"
mkdir -p ~/.config ~/.ssh

link_it () {
  SOURCE="${CURRENT_DIR}/$1"
  TARGET="${HOME}/$1"
  rm -rf "$TARGET"
  ln -vfFs "$SOURCE" "$TARGET"
}

link_it ".bash_profile"
link_it ".config/nvim"
link_it ".gemrc"
link_it ".git_template"
link_it ".gitconfig"
link_it ".gitignore-global"
link_it ".irbrc"
link_it ".ssh/config"
link_it ".tmux.conf"
link_it ".tmuxline.conf"
link_it ".vim"
link_it ".vimrc"
link_it ".zprofile"
link_it ".zshrc"
link_it ".ripgreprc"
link_it ".speedtest"
