export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true

ZSH_THEME="spaceship"
SPACESHIP_TIME_SHOW=false
SPACESHIP_GIT_PREFIX=" "
SPACESHIP_HG_SHOW=false
SPACESHIP_HG_BRANCH_SHOW=false
SPACESHIP_HG_STATUS_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_PREFIX=" "
SPACESHIP_RUBY_PREFIX=" "
SPACESHIP_RUBY_SYMBOL="💎  "
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=false

plugins=(bundler common-aliases docker docker-compose osx vi-mode npm git yarn)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

eval "$(rbenv init -)"

if [ ! -d "$HOME/.autoenv" ]; then
  echo "installing autoenv"
  git clone git://github.com/kennethreitz/autoenv.git "$HOME/.autoenv"
fi

export AUTOENV_ASSUME_YES="true"
export AUTOENV_ENABLE_LEAVE="true"
source ~/.autoenv/activate.sh


# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
