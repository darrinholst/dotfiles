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
link_it ".config/shbar"
link_it ".gitconfig"
link_it ".gitignore-global"
link_it ".hammerspoon"
link_it ".ssh/config"
link_it ".tmux.conf"
link_it ".tmuxline.conf"
link_it ".vim"
link_it ".vimrc"
link_it ".zprofile"
link_it ".zshrc"
link_it ".ripgreprc"
link_it ".speedtest"
link_it ".vpn"
link_it ".bin"
