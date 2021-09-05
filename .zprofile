export PATH=./node_modules/.bin:$PATH
export LESS="-FXr"

eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
