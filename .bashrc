# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR=mate
export GEM_OPEN_EDITOR=mate
export M2_HOME=/usr/local/maven
export MAVEN_OPTS="-Xmx1024m -Xms512m"
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JAVA_OPTS="-Xms256m -Xmx512m -XX:MaxPermSize=128m"
export MYSQL_HOME=/usr/local/mysql
export GROOVY_HOME=/usr/local/groovy
#export JRUBY_HOME=/usr/local/jruby

export PATH=$JAVA_HOME/bin:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MYSQL_HOME/bin:$PATH
export PATH=$GROOVY_HOME/bin:$PATH
#export PATH=$JRUBY_HOME/bin:$PATH
export PATH=~/.gem/ruby/1.8/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/local/bin:$PATH

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_BLUE="\[\033[1;34m\]"
COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) (of|by)"
  diverge_pattern="# Your branch and (.*) have diverged"

  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}⚡"
  fi

  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi

  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function prompt_func() {
  PS1="${LIGHT_BLUE}\w${GREEN}$(parse_git_branch)${LIGHT_BLUE} \$ ${COLOR_NONE}"
}

PROMPT_COMMAND=prompt_func

complete -C ~/.rake_complete.rb -o default rake
