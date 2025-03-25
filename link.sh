#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "$0")" ; pwd -P )"
mkdir -p ~/.config ~/.ssh

link_it () {
    SOURCE="${CURRENT_DIR}/$1"
    TARGET="${HOME}/$1"

    if [ ! -e "$SOURCE" ]; then
        return
    fi

    mkdir -p "$(dirname "$TARGET")"
    rm -rf "$TARGET"
    ln -vfs "$SOURCE" "$TARGET"
}

link_it ".bash_profile"
link_it ".config/nvim"
link_it ".gitconfig"
link_it ".gitignore-global"
link_it ".ssh/config"
link_it ".tmux.conf"
link_it ".tmuxline.conf"
link_it ".zprofile"
link_it ".zshrc"
link_it ".ripgreprc"
link_it ".bin"
link_it ".vpn"

if [[ "$OSTYPE" == "darwin"* ]]; then
    link_it ".hammerspoon"
fi

if grep -q "Alpine" /etc/os-release 2>/dev/null; then
    SOURCE="${CURRENT_DIR}/.zshrc.slim"
    TARGET="${HOME}/.zshrc"
    rm -rf "$TARGET"
    ln -vfs "$SOURCE" "$TARGET"
else
    link_it ".zshrc"
fi
