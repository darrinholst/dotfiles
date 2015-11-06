export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
plugins=(brew bundler gem git git-extras github gradle heroku knife osx npm rails rvm docker docker-compose common-aliases vi-mode)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

export PATH="$HOME/.rvm/bin:$PATH"

