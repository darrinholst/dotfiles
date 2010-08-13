# Our list of directorys we can cd to from anywhere
export CDPATH=.:~:~/Work:~/Work/geo

# Setup terminal, and turn on colors
export TERM=xterm-color
export CLICOLOR=1

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export RUBYOPT="rubygems"
export EDITOR=mate
export GEM_OPEN_EDITOR=mate
export M2_HOME=/usr/local/maven
export MAVEN_OPTS="-Xmx512m"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JAVA_OPTS="-Xms128m -Xmx256m -XX:MaxPermSize=128m"
export MYSQL_HOME=/usr/local/mysql
#export GROOVY_HOME=/usr/local/groovy
#export JRUBY_HOME=/usr/local/jruby
#export RUBY_ENTERPRISE_HOME=/usr/local/ruby-enterprise
export ANT_HOME=/usr/local/ant
export HOMEBREW_HOME=/usr/local/homebrew
export ANDROID_HOME=/usr/local/android

export PATH=./bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MYSQL_HOME/bin:$PATH
#export PATH=$GROOVY_HOME/bin:$PATH
export PATH=$ANT_HOME/bin:$PATH
export PATH=$HOMEBREW_HOME/bin:$PATH
#export PATH=$JRUBY_HOME/bin:$PATH
#export PATH=$RUBY_ENTERPRISE_HOME/bin:$PATH
#export PATH=~/.gem/ruby/1.8/bin:$PATH
export PATH=/usr/local/narwhal/bin:$PATH
