export PATH=~/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/munki
export HOMEBREW_CACHE=~/homebrew/cache

export PATH=$PATH:~/bin
export EDITOR="vim"
alias ssh=~/bin/ssh-change-bg
alias ls='exa -FG'
alias ll='exa -alFG'
alias rm='rm -i'
alias ..='cd ..'
alias mv='mv -i'
alias cp='cp -i'
alias hs='history | grep '
alias tree='tree -C'
alias lg='lazygit'
alias reload='source ~/.bashrc'
alias grep_routes='bundle exec rails routes | grep '
alias gdfw='git diff --color-words --word-diff-regex='\''\\w+|[^[:space:]]'\'''
alias ber='bundle exec rails'
alias be='bundle exec'
alias bi='bundle install'
alias d-c='docker-compose'
# GitのBranchを表示
#source ~/.git-prompt.sh
#export PS1='\h:\W \u \[\e[1;32m $(__git_ps1 "(%s)") \[\e[0m\] \$ '


export LSCOLORS=exfxcxdxbxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export ORACLE_HOME=~/Oracle\ Client/
export FORCE_RPATH=TRUE

RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[0;35m\]"
LIGHT_BLUE="\[\033[0;36m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[0;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[1;30m\]"
COLOR_OCHRE="\[\033[38;5;95m\]"
COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "nothing to commit, working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed:" ]]; then
    state="${YELLOW}"
  elif [[ ${git_status} =~ "Changes not staged for commit:" ]]; then
    state="${LIGHT_RED}"
  elif [[ ${git_status} =~ "Untracked files:" ]]; then
    state="${LIGHT_GREEN}"
  else
    state="${COLOR_OCHRE}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="^"
    else
      remote="v"
    fi
  else
    remote=""
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="^v"
  fi

  # Get the name of the branch.
  branch_pattern="^On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # Set the final branch string.
  BRANCH="${state}(${branch})${remote}${COLOR_NONE} "
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="${LIGHT_GRAY}\$${COLOR_NONE}"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${LIGHT_GREEN}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  # Set the bash prompt variable.
  PS1="
${PYTHON_VIRTUALENV}${BLUE}@\h ${GREEN}\w${COLOR_NONE} ${BRANCH}
${PROMPT_SYMBOL} "
}

function git-acp() {
  git add .
  git commit -am "$1"
  git push origin HEAD
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(goenv init -)"

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH=/usr/local/postgresql/12.3/bin/:$PATH
