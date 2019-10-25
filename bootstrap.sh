#!/bin/bash

# xcode command line tools are installed the first time you try to clone this repo
# xcode-select --install

sh ./link.sh

#~~~~~~~~~~~~~~~~~~~~#
#~ install homebrew ~#
#~~~~~~~~~~~~~~~~~~~~#
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew bundle install

#~~~~~~~~~~~~~~~~~~~#
#~ install ohmyzsh ~#
#~~~~~~~~~~~~~~~~~~~#
curl -L http://install.ohmyz.sh | sh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#~~~~~~~~~~~~~~#
#~ the colors ~#
#~~~~~~~~~~~~~~#
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~ python some crap for ultisnips in neovim ~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
sudo python -m ensurepip --default-pip
sudo python -m pip install --upgrade pynvim

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~ back to more sane stuff like javascript ~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
nodenv install 10.16.3 
nodenv global 10.16.3
