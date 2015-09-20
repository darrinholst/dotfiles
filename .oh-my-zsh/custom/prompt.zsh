function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%{$fg[yellow]%}(${ref#refs/heads/})$(git_status)"
}

function git_status() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    the_status="✗"
  fi

  if pushtime=$(git status 2>/dev/null | grep 'Your branch is ahead' 2> /dev/null); then
    the_status+="↑"
  fi

  if [[ -n $the_status ]]; then
    echo " $the_status "
  else
    echo " "
  fi
}

local ret_status="%(?:%{$fg_bold[green]%}✓ :%{$fg_bold[red]%}✗ %s)"

PROMPT='${fg_bold[blue]}%${PR_PWDLEN}<...<%~%<< $(git_prompt_info)
${ret_status}%{${reset_color}%}'

