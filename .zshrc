export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true

ZSH_THEME="spaceship"
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_RUBY_SYMBOL="💎  "

plugins=(bundler common-aliases docker docker-compose osx vi-mode npm git yarn)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
