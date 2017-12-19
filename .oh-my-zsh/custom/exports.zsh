set -o vi

# Our list of directorys we can cd to from anywhere
export CDPATH=.:~:~/Projects

# Setup terminal, and turn on colors
export TERM=xterm-color
export CLICOLOR=1

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export RUBYOPT="rubygems"
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export GOPATH=~/Projects/go
export GIT_EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export GEM_OPEN_EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export JAVA_HOME="`/usr/libexec/java_home -v '1.8*'`"
export JAVA_OPTS="-client -Xms64m -Xmx1024m"
export MAVEN_OPTS="-client -Xms64m -Xmx1024m"
export JRUBY_OPTS="--1.9"

export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=~/.bin:$PATH
export PATH=./bin:$PATH
export PATH=./script:$PATH

