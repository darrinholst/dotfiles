export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
plugins=(brew bundler gem git git-extras github gradle heroku knife osx npm rails rvm docker docker-compose common-aliases vi-mode)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
