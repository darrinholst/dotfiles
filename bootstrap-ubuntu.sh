#!/usr/bin/env zsh

if [ "$(ulimit -n)" -lt 65536 ]; then
    echo "Increasing file limits..."
    ulimit -n 65536 || true

    # Add permanent higher limits to system config if not already set
    if sudo grep -q "nofile" /etc/security/limits.conf; then
        echo "File limits already configured in /etc/security/limits.conf"
    else
        echo "Setting permanent file limits in /etc/security/limits.conf"
        echo "* soft nofile 65536" | sudo tee -a /etc/security/limits.conf
        echo "* hard nofile 65536" | sudo tee -a /etc/security/limits.conf
        echo "root soft nofile 65536" | sudo tee -a /etc/security/limits.conf
        echo "root hard nofile 65536" | sudo tee -a /etc/security/limits.conf
    fi

    # For systemd-based systems, also set limits there
    if [ -d "/etc/systemd/system.conf.d" ] || sudo mkdir -p /etc/systemd/system.conf.d; then
        if [ ! -f "/etc/systemd/system.conf.d/limits.conf" ]; then
            echo "Setting systemd file limits"
            echo "[Manager]" | sudo tee /etc/systemd/system.conf.d/limits.conf
            echo "DefaultLimitNOFILE=65536" | sudo tee -a /etc/systemd/system.conf.d/limits.conf
        fi
    fi

    echo "New file limits:"
    ulimit -n
fi

sudo apt update && sudo apt install -y build-essential curl file git zsh tmux

if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker $USER
fi

if ! command -v brew &> /dev/null; then
    NONINTERACTIVE=1 /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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

    if ! grep -q "HOMEBREW_MAKE_JOBS" ~/.zshrc; then
        echo 'export HOMEBREW_MAKE_JOBS=1' >> ~/.zshrc
    fi

    export HOMEBREW_MAKE_JOBS=1
fi

if command -v brew &> /dev/null; then
    brew doctor
    brew bundle install
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    curl -L http://install.ohmyz.sh | sh
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

if [ -f "./link.sh" ]; then
    source ./link.sh
fi

if [[ "$SHELL" == *"zsh"* ]]; then
    source ~/.zshrc
fi
