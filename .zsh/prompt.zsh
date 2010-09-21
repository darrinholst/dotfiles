function git_prompt_info {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(git status 2> /dev/null)"
  local remote_pattern="# Your branch is (.*) (of|by)"
  local diverge_pattern="# Your branch and (.*) have diverged"

  if [[ ! ${gitst} =~ "working directory clean" ]]; then
    state="${PR_RED}⚡"
  fi

  if [[ ${gitst} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${PR_YELLOW}↑"
    else
      remote="${PR_YELLOW}↓"
    fi
  fi

  if [[ ${gitst} =~ ${diverge_pattern} ]]; then
    remote="${PR_YELLOW}↕"
  fi

  if [[ -n $ref ]]; then
    echo "${PR_GREEN}(${ref#refs/heads/}$remote$state${PR_GREEN}) "
  fi
}

function rvm_version {
	if [ -f ~/.rvm/bin/rvm-prompt ]; then
	    rvm=$(~/.rvm/bin/rvm-prompt i v p g)
	    if [ "$rvm" -a "$rvm" != system ]; then
		    echo "{$rvm} "
	    fi
	fi
}

PROMPT='${PR_BOLD_BLUE}%${PR_PWDLEN}<...<%~%<< $(git_prompt_info)${PR_GREEN}$(rvm_version)${PR_BOLD_BLUE}
$%{${reset_color}%} '
