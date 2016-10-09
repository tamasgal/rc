NEWLINE=$'\n'

### Git [±master ▾●]

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[243]%}@"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}●%{$reset_color%}"

tamasgal_git_branch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

tamasgal_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
    echo -n ""
  else
    echo " %{$fg[red]%}$(basename $VIRTUAL_ENV)%{$reset_color%}"
  fi
}

tamasgal_git_status () {
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  _STATUS=""
  if $(echo "$_INDEX" | grep '^[AMRD]. ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi
  if $(echo "$_INDEX" | grep '^.[MTD] ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi
  if $(echo "$_INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi
  if $(echo "$_INDEX" | grep '^UU ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi
  if $(echo "$_INDEX" | grep '^## .*ahead' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | grep '^## .*behind' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | grep '^## .*diverged' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  echo $_STATUS
}

tamasgal_git_prompt () {
  local _branch=$(tamasgal_git_branch)
  local _status=$(tamasgal_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}

precmd() {
    print -rP $'%{$FG[239]%}%T %{$FG[031]%}%n%{$reset_color%}% @%{$FG[031]%}%m:%{$FG[248]%}%~ $(tamasgal_virtualenv)$(tamasgal_git_prompt)%{$reset_color%}'
    #print -rP $'%{$FG[031]%}%n%{$reset_color%}% @%{$FG[031]%}%m:%{$FG[248]%}%~ %{$FG[239]%}%T$(tamasgal_git_prompt) %{$reset_color%}'
#PROMPT=$'%{$FG[031]%}%n%{$reset_color%}% @%{$FG[031]%}%m:%{$FG[248]%}%~${NEWLINE}%{$FG[239]%}%T$(tamasgal_git_prompt) %{$FG[198]%}>%{$reset_color%} '
}

PROMPT=$'%{$FG[198]%}>%{$reset_color%} '
