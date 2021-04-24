export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=~/.bin:$PATH
export PATH=./bin:$PATH
export PATH=./script:$PATH
export LESS="-FXr"

eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
