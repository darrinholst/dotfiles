export NODE_HOME="/usr/local/opt/node@8"
export JAVA_HOME="`/usr/libexec/java_home -v '1.8*'`"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH=$NODE_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=~/.bin:$PATH
export PATH=./bin:$PATH
export PATH=./script:$PATH
export PATH="/usr/local/opt/awscli@1/bin:$PATH"
eval "$(rbenv init -)"