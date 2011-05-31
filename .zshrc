# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# export ZSH_THEME="robbyrussell"
# export ZSH_THEME="geoffgarside"
export ZSH_THEME="darrin"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler gem git osx rails3 rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:./bin:/Users/dholst/.rvm/gems/ruby-1.9.2-p180/bin:/Users/dholst/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/dholst/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/dholst/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/PalmPDK/bin:/opt/PalmSDK/0.1/bin/:/usr/X11/bin
