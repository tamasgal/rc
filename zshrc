[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

if [ -z "$PS1" ]; then
    return
fi

HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

fpath+=($HOME/.zsh/pure)
fpath+=("$(brew --prefix)/share/zsh/site-functions")

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Preferences
export JULIA_EDITOR="vim"
alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias juliap="julia --project=."
alias juliat="julia --project=. test/runtests.jl"
export PATH=$PATH:~/.config/emacs/bin
export PATH=$PATH:~/.local/bin
alias tl='tmux list-sessions'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# Misc functions
doi2bib ()
{
    echo >> bib.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> bib.bib;
    echo >> bib.bib
}

# Copy term info to target host
function termify() {
    infocmp $TERM | ssh $1 "mkdir -p .terminfo && mkdir -p tmp && cat > tmp/ti && tic tmp/ti"
}

# GPG
export GPG_TTY=$(tty)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Local adjustments
if [[ -f "$HOME/.zshrc_local" ]] then
  source $HOME/.zshrc_local
fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/tamasgal/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# .zshrc
autoload -U promptinit; promptinit
prompt pure
