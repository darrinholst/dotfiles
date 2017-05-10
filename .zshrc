export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
ZSH_THEME=""

#plugins=(brew bundler common-aliases docker docker-compose gem git git-extras github golang gradle gulp heroku jsontools knife osx npm rails rvm vi-mode)
plugins=(bundler common-aliases docker docker-compose osx vi-mode npm git yarn)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
