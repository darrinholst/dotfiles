# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Spaceship
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# oh-my-zsh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export ZSH=$HOME/.oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
plugins=(bundler common-aliases docker docker-compose osx vi-mode npm git git-extras yarn)
source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rando
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bindkey '^r' history-incremental-search-backward
unsetopt correct_all
set -o vi
export CDPATH=.:~:~/Projects:~/Projects/lt:~/Projects/deere
export TERM=xterm-color
export CLICOLOR=1
export EDITOR="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"
export GIT_EDITOR="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"
export GEM_OPEN_EDITOR="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The rubies
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(rbenv init -)"
export RUBYOPT="rubygems"
export ARCHFLAGS='-arch x86_64' # This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export JRUBY_OPTS="--1.9"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The javas
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export JAVA_OPTS="-client -Xms64m -Xmx1024m"
export MAVEN_OPTS="-client -Xms64m -Xmx1024m"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# autoenv
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [ ! -d "$HOME/.autoenv" ]; then
  echo "installing autoenv"
  git clone git://github.com/kennethreitz/autoenv.git "$HOME/.autoenv"
fi

export AUTOENV_ASSUME_YES="true"
export AUTOENV_ENABLE_LEAVE="true"
source ~/.autoenv/activate.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# autocomplete stuff I copied from the INTERNET
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# aliases
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias listening='lsof -i -P | grep -i listen'
alias vim="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"
alias tmux='tmux -2 -u'
alias git=hub
alias gpf='git push --force-with-lease'
alias gbdf='git branch -D'
alias run='npm run'
alias code='code-insiders'
alias cr='code-insiders -r'
alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'

eval "$(nodenv init -)"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The colors
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
#base16_solarized-light
base16_tomorrow-night

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Enter the rest at your own risk
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

clean-vim() {
  rm -rf ~/.vim/backup/*.sw*
}

clean-docker() {
  docker images -q --filter "dangling=true" | xargs docker rmi
}

clean-node() {
  killall node
}

any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

fp() { # find and list processes matching a case-insensitive partial-match string
  ps Ao pid,comm|awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'|grep -i $1|grep -v grep
}

fk() { # build menu to kill process
  IFS=$'\n'
  PS3='Kill which process? '
  select OPT in $(fp $1) "Cancel"; do
    if [ $OPT != "Cancel" ]; then
      kill $(echo $OPT|awk '{print $NF}')
    fi
    break
  done
  unset IFS
}

lips() {
  local ip=`ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`
  local locip extip

  [ "$ip" != "" ] && locip=$ip || locip="inactive"

  ip=`dig +short myip.opendns.com @resolver1.opendns.com`
  [ "$ip" != "" ] && extip=$ip || extip="inactive"

  printf '%11s: %s\n%11s: %s\n' "Local IP" $locip "External IP" $extip
}

attach() {
  tmux attach -t $1 || tmux new -s $1
}

nvm-load() {
  source "$HOME/.nvm/nvm.sh"
}

swagger-editor() {
  docker run -ti --rm --volume="$(pwd)":/swagger -p 8080:8080 zixia/swagger-edit "$@"
}
