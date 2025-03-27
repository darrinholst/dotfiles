#!/bin/bash

# xcode command line tools are installed the first time you try to clone this repo
# xcode-select --install

defaults write -g ApplePressAndHoldEnabled -bool false || true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true || true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 || true

#~~~~~~~~~~~~~~~~~~~~#
#~ install homebrew ~#
#~~~~~~~~~~~~~~~~~~~~#
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew bundle install

#~~~~~~~~~~~~~~~~~~~#
#~ install ohmyzsh ~#
#~~~~~~~~~~~~~~~~~~~#
curl -L http://install.ohmyz.sh | sh
source ./link.sh
source ~/.zshrc
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#~~~~~~~~~~~~~~~~~~~~~~~#
#~ tmux plugin manager ~#
#~~~~~~~~~~~~~~~~~~~~~~~#
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#~~~~~~~~~~~~~~#
#~ the colors ~#
#~~~~~~~~~~~~~~#
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~ python some crap for ultisnips in neovim ~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
sudo python -m ensurepip --default-pip
sudo python -m pip install --upgrade pynvim neovim

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~ back to more sane stuff like javascript ~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
nodenv install 16.16.0
nodenv install 16.17.0
nodenv global 16.17.0
