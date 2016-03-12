export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
plugins=(brew bundler common-aliases docker docker-compose gem git git-extras github golang gradle gulp heroku jsontools knife osx npm rails rvm vi-mode)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
