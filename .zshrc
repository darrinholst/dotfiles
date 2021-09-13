source ~/.zprofile

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
plugins=(bundler colored-man-pages common-aliases docker docker-compose encode64 osx vi-mode npm git git-auto-fetch git-extras history-substring-search)
source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rando
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bindkey '^r' history-incremental-search-backward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

unsetopt correct_all
set -o vi
export CDPATH=.:~:~/projects:~/projects/aa
export TERM=xterm-color
export CLICOLOR=1
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export GEM_OPEN_EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --files --follow -uu --hidden'
export FZF_DEFAULT_OPTS='--bind ctrl-e:up'
export AWS_CLI_AUTO_PROMPT=on
export RIPGREP_CONFIG_PATH=~/.ripgreprc


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The rubies
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export ARCHFLAGS='-arch x86_64' # This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The javas
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export JAVA_OPTS="-client -Xms64m -Xmx1024m"
export MAVEN_OPTS="-client -Xms64m -Xmx1024m"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The javascripts
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export PATH=./node_modules/.bin:$PATH
eval "$(nodenv init -)"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# direnv
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

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
alias vim="nvim"
alias tmux='tmux -2 -u'
alias git=hub
alias gpf='git push --force-with-lease'
alias gcm='git checkout $(git default-branch)'
alias gu='git up'
alias run='npm run'
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias fp=any
alias tig='tig --no-merges'
alias py=python3
alias ti="(cd terraform && ./setup-terraform-local.sh)"
alias tf="terraform fmt terraform"
alias tp="terraform -chdir=terraform plan --var-file terraform.tfvars"
alias ta="terraform -chdir=terraform apply --var-file terraform.tfvars"
alias tpt="terraform -chdir=terraform plan --var-file test.tfvars"
alias tat="terraform -chdir=terraform apply --var-file test.tfvars"
alias tpp="terraform -chdir=terraform plan --var-file prod.tfvars"
alias tap="terraform -chdir=terraform apply --var-file prod.tfvars"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The colors
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_tomorrow-night

autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 🤫 secret stuff goes in this file
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Enter the rest at your own risk
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

b64() {
  echo -n "$1" | openssl base64
}

clean-vim() {
  rm -rf ~/.vim/backup/*.sw*
}

clean-docker() {
  docker system prune
}

clean-node() {
  killall node
}

clean-cache() {
  sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder
}

# find and list processes matching a case-insensitive partial-match string...I think
any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any " >&2 ; return 1
  else
    ps ax -o pid,user,start,command | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

fk() { # build menu to kill process
  IFS=$'\n'
  PS3='Kill which process? '

  select OPT in "All" $(fp $1) "Cancel"; do
    if [ $OPT != "Cancel" ]; then
      if [ $OPT != "All" ]; then
        local PROCESSES=$OPT
      else
        local PROCESSES=$(fp $1)
      fi

      for PID in $(echo $PROCESSES|awk '{print $1}'); do
        kill -9 $PID
      done
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

untilfails() {
  while $@; do :; done
}

which-dns() {
  networksetup -getdnsservers Wi-Fi
}

use-opendns() {
  networksetup -setdnsservers Wi-Fi 208.67.222.222 208.67.220.220
  which-dns
}

use-cloudflare() {
  networksetup -setdnsservers Wi-Fi 1.1.1.1
  which-dns
}

use-google() {
  networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
  which-dns
}

