clean-vim() {
  rm -rf ~/.vim/backup/*.sw*
}

clean-docker() {
  docker images -q --filter "dangling=true" | xargs docker rmi
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
