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

link_slim () {
    SOURCE_FILE="$1"
    SLIM_SUFFIX="${2:-.slim}"

    if grep -q "Alpine" /etc/os-release 2>/dev/null; then
        # On Alpine, link the slim version
        SOURCE="${CURRENT_DIR}/${SOURCE_FILE}${SLIM_SUFFIX}"
        TARGET="${HOME}/${SOURCE_FILE}"

        if [ ! -e "$SOURCE" ]; then
            link_it "${SOURCE_FILE}"
            return
        fi

        mkdir -p "$(dirname "$TARGET")"
        rm -rf "$TARGET"
        ln -vfs "$SOURCE" "$TARGET"
    else
        link_it "${SOURCE_FILE}"
    fi
}

link_it ".bash_profile"
link_it ".config/nvim"
link_it ".gitconfig"
link_it ".gitignore-global"
link_it ".ssh/config"
link_it ".tmuxline.conf"
link_it ".zprofile"
link_it ".ripgreprc"
link_it ".bin"
link_it ".vpn"
link_slim ".zshrc"
link_slim ".tmux.conf"

# tinted-shell hooks
if [ -d "$HOME/.config/tinted-theming/tinted-shell/hooks" ]; then
    for hook in "$CURRENT_DIR"/tinted-hooks/*.sh; do
        [ -f "$hook" ] && ln -vfs "$hook" "$HOME/.config/tinted-theming/tinted-shell/hooks/$(basename "$hook")"
    done
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    link_it ".hammerspoon"
fi
