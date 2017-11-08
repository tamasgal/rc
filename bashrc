# ~/.bashrc: executed by bash(1) for non-login shells.

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Dev
source /usr/local/bin/virtualenvwrapper.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then                            
  . $(brew --prefix)/etc/bash_completion                                        
fi 

source_dir()
{
    local dir="$1"
    if [[ -d $dir ]]
    then
        local conf_file
        for conf_file in "$dir"/*
        do
            if [[ -f $conf_file && $(basename $conf_file) != 'README' ]]
            then
                source "$conf_file"
            fi
        done
    fi
}

source_dir ~/.bash.d/local/before
source_dir ~/.bash.d
source_dir ~/.bash.d/local/after

. $(brew --prefix root)/libexec/thisroot.sh
export PATH=/usr/local/sbin:$PATH

export PATH="$PATH:/Applications/DevDesktop/drush"

# added by travis gem
[ -f /Users/tamasgal/.travis/travis.sh ] && source /Users/tamasgal/.travis/travis.sh
