# Our list of directorys we can cd to from anywhere
export CDPATH=.:~:~/work:~/Dropbox

# Setup terminal, and turn on colors
export TERM=xterm-color
export CLICOLOR=1

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export RUBYOPT="rubygems"
export EDITOR=mvim
export GEM_OPEN_EDITOR=mvim
export MAVEN_OPTS="-d32 -client -Xmx1024" # -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=4000"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JAVA_OPTS="-d32 -client -Xms64m -Xmx256m -XX:MaxPermSize=128m"

export PATH=./bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH

