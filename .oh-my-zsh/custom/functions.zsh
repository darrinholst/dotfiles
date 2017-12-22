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

clear-proxy() {
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset http_proxy
  unset https_proxy
  unset NPM_CONFIG_PROXY
  unset NPM_CONFIG_HTTPS_PROXY
}
