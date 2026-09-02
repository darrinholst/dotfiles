source ~/.zprofile
unsetopt correct_all
set -o vi
export CDPATH=.:~:~/projects:~/projects/aa:~/projects/aa/modules:~/projects/aa/inf:~/projects/aa/apps

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# oh-my-zsh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export ZSH=$HOME/.oh-my-zsh
zstyle ':omz:update' mode auto
plugins=(\
  autojump \
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
# Starship (Prompt)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(starship init zsh)"

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
# aiiiiiiiiiiiiiiiiiiiiiii
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias oc="opencode"
alias cc="claude"

bpi() {
  local profile="${AWS_PROFILE:-test}"
  if ! aws configure export-credentials --profile "$profile" --format env >/dev/null 2>&1; then
    aws sso login --profile "$profile" || return 1
  fi
  eval "$(aws configure export-credentials --profile "$profile" --format env)" || return 1
  pi "$@"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias vi="nvim -u NONE"
alias vim='NVIM_APPNAME="nvim" nvim'
export EDITOR="nvim"
export GIT_EDITOR="nvim"
bindkey -v

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# js
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export PATH=~/.bin:./node_modules/.bin:$PATH
alias run='npm run'

which-node() {
  find . -name node_modules -prune -o -name .node-version -exec printf "%s " {} \; -exec cat {} \;
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# mise
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(mise activate zsh)"

wtf-node-modules() {
  find . -type d -name node_modules -prune | tr '\n' '\0' |  xargs -0 du -sch
}

clean-node-modules() {
  wtf-node-modules && find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;
  # npx -y npkill
}

clean-terraform() {
  find . -name '.terraform' -type d -prune -print -exec rm -rf '{}' \;
}

clean-mac() {
  find . -name '.DS_Store' -type f -prune -print -exec rm -rf '{}' \;
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# git
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias lg=lazygit
alias git=hub
alias tig='tig --no-merges'
alias gfu='git fu'
alias gba='git branch --all --color="always" --sort=authordate --format="%(color:blue)%(authordate:relative);%(color:red)%(authorname);%(color:white)%(color:bold)%(refname:short)" "$@" | column -s ";" -t'
alias gu='git fetch && git up'
alias gs='git st'
alias ga='git ad'
alias gca='git commit -v --amend'
alias gcan='git commit -v --amend --no-edit'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# worktrees
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WT_SKIP=(.worktrees worktrees .git .DS_Store)

wt-root() {
  local common=$(command git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || return 1
  print -r -- "${${common:h}:A}"
}

wt-linked() {
  local root=$(wt-root) || return 1
  command git worktree list --porcelain 2>/dev/null | awk -v prefix="$root/.worktrees/" '
    /^worktree /{ dir = substr($0, 10) }
    /^branch /{ sub(/^refs\/heads\//, "", $2); if (index(dir, prefix) == 1) print $2 }
  '
}

wt() {
  local root=$(wt-root) || return 1

  if [[ -z $1 ]]; then
    local picked=$(command git worktree list | fzf --height 40% --reverse --inline-info | awk '{print $1}')
    [[ -n $picked ]] && cd "$picked"
    return
  fi

  local dir=$root/.worktrees/${1//\//-}

  if [[ ! -d $dir ]]; then
    command git -C "$root" worktree add "$dir" "$1" 2>/dev/null ||
      command git -C "$root" worktree add --track -b "$1" "$dir" "origin/$1" 2>/dev/null ||
      command git -C "$root" worktree add -b "$1" "$dir" || return 1
    wt-seed "$root" "$dir"
  fi

  cd "$dir"
}

wt-seed() {
  local src=$1 dst=$2 entry skip
  local -a entries pairs
  entries=(${(f)"$(command git -C "$src" ls-files --others --ignored --exclude-standard --directory)"})

  for entry in $entries; do
    entry=${entry%/}
    for skip in $WT_SKIP; do
      [[ $entry == $skip || $entry == $skip/* || ${entry:t} == $skip ]] && continue 2
    done
    [[ -e $dst/$entry ]] && continue
    pairs+=("$src/$entry" "$dst/$entry")
  done

  if (( $#pairs )); then
    print -rN -- $pairs | wt-clone ||
      for entry in ${pairs[1,-1,2]}; do
        cp -Rc "$entry" "$dst/${entry#$src/}"
      done
  fi

  [[ -x $dst/.wt-setup ]] && (cd "$dst" && ./.wt-setup)
  return 0
}

wtrm() {
  local root=$(wt-root) || return 1
  local branch=${1:-$(command git branch --show-current)}
  cd "$root" &&
    command git worktree remove --force "$root/.worktrees/${branch//\//-}" &&
    command git branch -D "$branch" &&
    command git worktree prune
}

_wt() {
  local -a linked others
  linked=(${(f)"$(wt-linked)"})
  others=(${(f)"$(command git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"})
  others+=(${(f)"$(command git for-each-ref --format='%(refname:short)' refs/remotes 2>/dev/null | sed 's|^[^/]*/||')"})
  others=(${(u)${others:#HEAD}:|linked})

  _alternative \
    "worktrees:worktree:compadd -a linked" \
    "branches:branch:compadd -a others"
}

_wtrm() {
  local -a linked
  linked=(${(f)"$(wt-linked)"})
  _describe -t worktrees worktree linked
}

compdef _wt wt
compdef _wtrm wtrm

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# terraform
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias ti="(cd terraform && ./setup-terraform-local.sh)"
alias tf="terraform fmt terraform"
alias tsl="terraform -chdir=terraform state list"
alias trm="terraform -chdir=terraform rm"

alias tp="terraform -chdir=terraform plan --var-file terraform.tfvars"
alias ta="terraform -chdir=terraform apply --var-file terraform.tfvars"

alias tpt="terraform -chdir=terraform plan --var-file test.tfvars"
alias tat="terraform -chdir=terraform apply --var-file test.tfvars"
alias tit="terraform -chdir=terraform --var-file test.tfvars import"

alias tpp="terraform -chdir=terraform plan --var-file prod.tfvars"
alias tap="terraform -chdir=terraform apply --var-file prod.tfvars"
alias tip="terraform -chdir=terraform --var-file prod.tfvars import"

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

BASE16_SHELL_PATH="$HOME/.config/tinted-theming/tinted-shell"
export BASE16_SHELL_ENABLE_VARS=1
[ -n "$PS1" ] && [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && source "$BASE16_SHELL_PATH/profile_helper.sh"
base16_catppuccin-mocha
# base16_catppuccin-latte

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# docker
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clean-docker() {
  # docker container prune -f && docker image prune -f && docker network prune -f
  docker system prune --all --force --volumes
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# dev
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias local-dev='tmux -2 -u attach -t 0 || tmux -2 -u new -s 0'
alias ha-dev='ssh homeassistant -t "tmux -2 -u attach -t 0 || tmux -2 -u new -s 0"'

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

untilworks() {
  while ! $@; do :; done
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

# opencode
export PATH=/Users/darrinholst/.opencode/bin:$PATH

# go
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
