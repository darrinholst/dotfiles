export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
ZSH_THEME=""

plugins=(bundler common-aliases docker docker-compose osx vi-mode npm git)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
