source ~/.zprofile
unsetopt correct_all
set -o vi
export CDPATH=.:~:~/projects:~/projects/aa:~/projects/aa/modules:~/projects/aa/inf:~/projects/aa/apps

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Spaceship (Prompt)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ZSH_THEME="spaceship"
SPACESHIP_AWS_SHOW=false
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=30
SPACESHIP_CONDA_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_HG_BRANCH_SHOW=false
SPACESHIP_HG_SHOW=false
SPACESHIP_HG_STATUS_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_NODE_SHOW=true
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_RUBY_SHOW=true
SPACESHIP_RUST_SHOW=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_TIME_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_PROMPT_PREFIXES_SHOW=false

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# oh-my-zsh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export ZSH=$HOME/.oh-my-zsh
zstyle ':omz:update' mode auto
plugins=(\
  autojump \
  bundler \
  colored-man-pages \
  common-aliases \
  docker \
  docker-compose \
  encode64 \
  fzf \
  git \
  git-auto-fetch \
  git-extras \
  history-substring-search \
  macos \
  npm \
  vi-mode \
)
source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# fzf
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude \".git\" . ~/projects"
export FZF_DEFAULT_COMMAND='rg --files --follow -uu --hidden'
export FZF_DEFAULT_OPTS='--bind ctrl-e:up'
bindkey '^r' fzf-history-widget

j() {
  if [[ "$#" -ne 0 ]]; then
    cd $(autojump $@)
    return
  fi
  cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias vi="nvim -u NONE"
alias vim="nvim"
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# js
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(nodenv init -)"
export PATH=~/.bin:./node_modules/.bin:$PATH
alias npm='~/.nodenv/shims/npm'
alias run='npm run'

wtf-node-modules() {
  find . -type d -name node_modules -prune | tr '\n' '\0' |  xargs -0 du -sch
}

clean-node-modules() {
  wtf-node-modules && find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;
}

clean-terraform() {
  find . -name '.terraform' -type d -prune -print -exec rm -rf '{}' \;
}

clean-mac() {
  find . -name '.DS_Store' -type f -prune -print -exec rm -rf '{}' \;
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# direnv
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# git
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias git=hub
alias tig='tig --no-merges'
alias gfu='git fu'
alias gba='git branch --all --color="always" --sort=authordate --format="%(color:blue)%(authordate:relative);%(color:red)%(authorname);%(color:white)%(color:bold)%(refname:short)" "$@" | column -s ";" -t'
alias gu='git fetch && git up'
alias gs='git st'
alias ga='git ad'
alias gca='git commit -v --amend'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# terraform
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias ti="(cd terraform && ./setup-terraform-local.sh)"
alias tf="terraform fmt terraform"
alias tp="terraform -chdir=terraform plan --var-file terraform.tfvars"
alias ta="terraform -chdir=terraform apply --var-file terraform.tfvars"
alias tpt="terraform -chdir=terraform plan --var-file test.tfvars"
alias tat="terraform -chdir=terraform apply --var-file test.tfvars"
alias tpp="terraform -chdir=terraform plan --var-file prod.tfvars"
alias tap="terraform -chdir=terraform apply --var-file prod.tfvars"

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
# tmux
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias tmux='tmux -2 -u'

attach() {
  tmux attach -t $1 || tmux new -s $1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# colors
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export TERM=xterm-256color
export CLICOLOR=1
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_tomorrow-night

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# docker
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clean-docker() {
  docker container prune -f && docker image prune -f && docker network prune -f
  # docker system prune --all --force --volumes
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# dns
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clean-dns() {
  sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder
}

which-dns() {
  networksetup -getdnsservers Wi-Fi
}

use-cloudflare() {
  networksetup -setdnsservers Wi-Fi 1.1.1.1 208.67.222.222 208.67.220.220
  which-dns
}

use-test() {
  networksetup -setdnsservers Wi-Fi 10.2.0.2 1.1.1.1 208.67.222.222 208.67.220.220
  which-dns
}

use-prod() {
  networksetup -setdnsservers Wi-Fi 172.31.0.2 1.1.1.1 208.67.222.222 208.67.220.220
  which-dns
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# utils
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias awsauto='aws --cli-auto-prompt'
alias yalc='npx yalc'
alias gall='gita super'

untilfails() {
  while $@; do :; done
}

listening() {
  lsof -i -P | grep -i listen
}


ip() {
  local ip=`ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`
  local locip extip

  [ "$ip" != "" ] && locip=$ip || locip="inactive"

  ip=`dig +short myip.opendns.com @resolver1.opendns.com`
  [ "$ip" != "" ] && extip=$ip || extip="inactive"

  printf '%11s: %s\n%11s: %s\n' "Local IP" $locip "External IP" $extip
}

alias any=fp

fp() { # find and list processes matching a case-insensitive partial-match string...I think
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "fp - grep for process(es) by keyword" >&2
    echo "Usage: fp " >&2 ; return 1
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 🤫 secret stuff goes in this file
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

eval "$(rbenv init - zsh)"

