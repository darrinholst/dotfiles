export ZSH=$HOME/.oh-my-zsh
#export DISABLE_AUTO_UPDATE="true"
plugins=(brew bundler gem git github osx rails rvm)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

DISABLE_UPDATE_PROMPT=true
