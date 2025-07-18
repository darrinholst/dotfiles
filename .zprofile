export LESS="-FXr"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" $HOME/.bin/diff-highlight

if command -v brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source ~/.orbstack/shell/init.zsh 2>/dev/null || :
