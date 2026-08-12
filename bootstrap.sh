#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

log() {
    printf '\n\033[1;34m==>\033[0m %s\n' "$*"
}

ensure_xcode_tools() {
    if xcode-select -p >/dev/null 2>&1; then
        return
    fi

    log "Installing Xcode command line tools"
    xcode-select --install
    echo "Finish the installer, then re-run this script."
    exit 1
}

set_macos_defaults() {
    log "Setting macOS defaults"
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}

install_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        log "Installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    for prefix in /opt/homebrew /usr/local; do
        if [[ -x "$prefix/bin/brew" ]]; then
            eval "$("$prefix/bin/brew" shellenv)"
            break
        fi
    done

    log "Installing Brewfile packages"
    brew bundle install --file="$DOTFILES/Brewfile"
}

install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        return
    fi

    log "Installing oh-my-zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

clone_or_update() {
    local repo="$1" dest="$2"

    if [[ -d "$dest/.git" ]]; then
        git -C "$dest" pull --ff-only
    else
        mkdir -p "$(dirname "$dest")"
        git clone --depth 1 "$repo" "$dest"
    fi
}

install_tmux_plugin_manager() {
    log "Installing tmux plugin manager"
    clone_or_update https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

install_tinted_shell() {
    log "Installing tinted-shell"
    clone_or_update https://github.com/tinted-theming/tinted-shell \
        "$HOME/.config/tinted-theming/tinted-shell"
}

link_dotfiles() {
    log "Linking dotfiles"
    "$DOTFILES/link.sh"
}

install_languages() {
    log "Installing language runtimes with mise"

    if ! mise ls --global 2>/dev/null | grep -q '^node'; then
        mise use --global node@lts
    fi

    mise install
}

ensure_xcode_tools
set_macos_defaults
install_homebrew
install_oh_my_zsh
install_tmux_plugin_manager
install_tinted_shell
link_dotfiles
install_languages

log "Done. Restart your shell (or run: exec zsh)"
