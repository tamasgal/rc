if [ -z "$PS1" ]; then
    return
fi

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_SHOW_FULL="true"
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=":"
SPACESHIP_HOST_COLOR="blue"
SPACESHIP_TIME_SHOW="true"
SPACESHIP_EXIT_CODE_SHOW="true"
SPACESHIP_PYENV_SYMBOL="py-"
SPACESHIP_DOCKER_SYMBOL="do-"
SPACESHIP_DOCKER_PREFIX=""
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_COLOR="black"
SPACESHIP_GIT_STATUS_ADDED="%F{154}●%F{black}"
SPACESHIP_GIT_STATUS_MODIFIED="%F{172}●%F{black}"
SPACESHIP_GIT_STATUS_UNTRACKED="%F{196}●%F{black}"
SPACESHIP_GIT_STATUS_RENAMED="%F{148}»%F{black}"
SPACESHIP_GIT_STATUS_DELETED="%F{202}x%F{black}"
SPACESHIP_GIT_STATUS_STASHED="%F{142}$%F{black}"
SPACESHIP_GIT_STATUS_AHEAD="%F{081}⇡%F{black}"
SPACESHIP_GIT_STATUS_BEHIND="%F{081}⇡%F{black}"
SPACESHIP_GIT_STATUS_DIVERGED="%F{081}⇕%F{black}"
SPACESHIP_TIME_COLOR="grey"
SPACESHIP_TIME_PREFIX=""
SPACESHIP_USER_PREFIX=""
SPACESHIP_USER_SUFFIX=""
SPACESHIP_USER_SHOW="always"
SPACESHIP_USER_COLOR="blue"
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_COLOR="grey"
SPACESHIP_VI_MODE_INSERT="%F{red}░"
SPACESHIP_VI_MODE_NORMAL="%F{grey}░"
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_CHAR_SYMBOL="%F{blue}> "
SPACESHIP_EXIT_CODE_SYMBOL=""
SPACESHIP_PROMPT_ORDER=(
  vi_mode       # Vi-mode indicator
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  # package       # Package version
  # node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubecontext   # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  time          # Time stamps section
  battery       # Battery level and status
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
#export LS_COLORS="di=1;31:ln=36:so=32:pi=33:ex=32:bd=34;46:cd=34:su=0:sg=0:tw=0:ow=0:"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions docker tmux tmuxinator vi-mode osx git git-extras git-flow svn cabal history-substring-search colored-man-pages cp fasd extract pass)

# User configuration

source $HOME/.zshrc_local
source $ZSH/oh-my-zsh.sh

# Misc Python
export PYTHON_CONFIGURE_OPTS="--enable-shared"

# Virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"                  # $EDITOR opens in terminal
export VISUAL="emacsclient"         # $VISUAL opens in GUI mode
export USE_EDITOR="$EDITOR"
export JULIA_EDITOR="$EDITOR"
alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"

# ix paster
alias ix="curl -n -F 'f:1=<-' http://ix.io "

# Jupyter
alias nbview="jupyter nbconvert --to slides --post serve "

# Julia
alias julia_dev="$HOME/Dev/julia/julia"
alias juliap="julia --project=."
alias juliat="julia --project=. test/runtests.jl"

# nim
export PATH=$HOME/.nimble/bin:$PATH

# doom emacs
export PATH=$PATH:~/.emacs.d/bin

# lean/elan
export PATH=$PATH:$HOME/.elan/bin

# Kitty icat
alias icat="kitty +kitten icat"

# Profile
function profile() { 
    python -m cProfile -o ~/tmp/temp.profile $1
    snakeviz ~/tmp/temp.profile
}

# copy terminfo
function cp_terminfo() {
    infocmp st-256color|ssh $1 "mkdir -p .terminfo && cat >/tmp/ti && tic /tmp/ti"
}

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# VI mode
bindkey -v
export KEYTIMEOUT=1

# Misc functions
doi2bib ()
{
    echo >> bib.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> bib.bib;
    echo >> bib.bib
}

# GPG
export GPG_TTY=$(tty)

# AnyBar
function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

# base16 and tmux
tmux_light() {
  tmux source-file ~/.rc/tmux-colors/tmuxcolors-light.conf
}
tmux_dark() {
  tmux source-file ~/.rc/tmux-colors/tmuxcolors-dark.conf
}

# Copy term info to target host
function termify() {
    infocmp $TERM | ssh $1 "mkdir -p .terminfo && mkdir -p tmp && cat > tmp/ti && tic tmp/ti"
}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Fix numeric keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
bindkey -s "^[OX" "="

source $ZSH/plugins/history-substring-search/history-substring-search.zsh

remember() { echo "$@" >> remember.log && $@ }

#source ~/.rc/colors

# Disable auto cd
unsetopt AUTO_CD

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
