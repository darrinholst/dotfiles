export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
plugins=(brew bundler gem git git-extras github gradle knife osx npm rails rvm docker common-aliases berkshelf)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

export PATH="$HOME/.rvm/bin:$PATH"

