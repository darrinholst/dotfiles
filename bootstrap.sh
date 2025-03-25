#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v xcode-select &> /dev/null; then
        echo "Installing Xcode command line tools..."
        xcode-select --install
    fi

    defaults write -g ApplePressAndHoldEnabled -bool false || true
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true || true
    sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || true
    sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || true
elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "linux"* ]]; then
    if [ -f /etc/alpine-release ]; then
        DISTRO="alpine"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        DISTRO=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/system-release ]; then
        if grep -q "Amazon Linux" /etc/system-release; then
            DISTRO="amazon"
        else
            DISTRO="rhel"
        fi
    else
        DISTRO="unknown"
    fi

    echo "Detected Linux distribution: $DISTRO"

    case $DISTRO in
        alpine)
            echo "Installing dependencies for Alpine Linux..."
            sudo apk update
            sudo apk add \
                git \
                zsh \
                tmux \
                neovim \
                curl \
                ripgrep \
                fd \
                fzf \
                autojump \
                build-base \
                tree-sitter \
                tree-sitter-dev \
                luajit \
                luajit-dev \
                cmake \
                make \
                gcc \
                g++ \
                python3 \
                python3-dev
            ;;
        ubuntu|debian)
            echo "Installing dependencies for Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y build-essential curl file git zsh tmux
            ;;
        amazon|rhel|centos|fedora)
            echo "Installing dependencies for Amazon Linux/RHEL..."
            sudo yum update -y
            sudo yum groupinstall -y 'Development Tools'
            sudo yum install -y curl file git zsh tmux
            ;;
    esac
fi

#~~~~~~~~~~~~~~~~~~~~#
#~ install homebrew ~#
#~~~~~~~~~~~~~~~~~~~~#
if [[ "$DISTRO" != "alpine" ]] && ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "linux"* ]]; then
        test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
        test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        for PROFILE in ~/.profile ~/.bash_profile ~/.bashrc ~/.zshrc; do
            if [ -f "$PROFILE" ]; then
                if ! grep -q "brew shellenv" "$PROFILE"; then
                    echo "Adding Homebrew to $PROFILE"
                    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$PROFILE"
                fi
            fi
        done

        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

if [[ "$DISTRO" != "alpine" ]] && command -v brew &> /dev/null; then
    brew doctor
    brew bundle install
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    curl -L http://install.ohmyz.sh | sh
fi

if [ -f "./link.sh" ]; then
    source ./link.sh
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
    echo "Installing base16-shell..."
    mkdir -p ~/.config
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

if [[ "$SHELL" == *"zsh"* ]]; then
    source ~/.zshrc
fi


