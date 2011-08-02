function rvm_version {
  if [ -f ~/.rvm/bin/rvm-prompt ]; then
      rvm=$(~/.rvm/bin/rvm-prompt i v p g)
      if [ "$rvm" -a "$rvm" != system ]; then
        echo "{$rvm} "
      fi
  fi
}

PROMPT='${fg_bold[blue]}%${PR_PWDLEN}<...<%~%<< $(git_prompt_info)${fg_bold[red]}$(rvm_version)${fg_bold[blue]}
$%{${reset_color}%} '

RPROMPT='[%*]'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg[yellow]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=") "

