alias tree="find . -print | sed -e 's;[^/]*/;|___;g;s;___|; |;g'"

ruby_or_irb () {
  if [ "$1" == "" ]; then
irb
  else
ruby "$@"
  fi
}

alias ruby="ruby_or_irb"