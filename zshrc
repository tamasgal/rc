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

# fpath+=($HOME/.zsh/pure)
# fpath+=("$(brew --prefix)/share/zsh/site-functions")

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias ipythonp='. venv/bin/activate && ipython'
alias pythonp='. venv/bin/activate && python'
alias venv='python3 -m venv venv && . venv/bin/activate'

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

c99cheatsheet() {
    cat <<'EOF'
<assert.h>   assert()
<errno.h>    errno, EINVAL, ENOMEM, ...
<stddef.h>   NULL, size_t, ptrdiff_t, offsetof()
<stdlib.h>   malloc(), calloc(), realloc(), free(), atoi(), atof(), strtol(), strtod(), rand(), srand(), exit(), atexit(), system(), qsort(), bsearch(), abs(), labs()
<stdbool.h>  bool, true, false
<stdint.h>   int8_t...int64_t, uint8_t...uint64_t, INT32_MAX, UINT64_C()
<stdio.h>    fopen(), fclose(), fread(), fwrite(), printf(), fprintf(), sprintf(), snprintf(), scanf(), fscanf(), sscanf(), fseek(), ftell(), rewind(), perror()
<ctype.h>    isalpha(), isdigit(), isalnum(), isspace(), tolower(), toupper()
<string.h>   memcpy(), memmove(), strcpy(), strncpy(), strcat(), strncat(), strcmp(), strncmp(), memcmp(), strchr(), strstr(), memchr(), strlen(), memset()
<math.h>     sin(), cos(), tan(), exp(), log(), log10(), pow(), sqrt(), fabs(), floor(), ceil(), fmod()
<float.h>    FLT_MAX, DBL_MIN, LDBL_EPSILON
<limits.h>   INT_MAX, LONG_MIN, CHAR_BIT
<time.h>     time_t, struct tm, time(), difftime(), mktime(), localtime(), gmtime(), strftime(), clock()
<stdarg.h>   va_list, va_start(), va_arg(), va_end()
<setjmp.h>   setjmp(), longjmp()
<signal.h>   signal(), raise()
EOF
}


# .zshrc
# autoload -U promptinit; promptinit
# prompt pure
fpath+=( $HOME/.agkozak-zsh-prompt )  # The directory where the prompt's
                                        # files are kept
autoload promptinit; promptinit
AGKOZAK_PROMPT_CHAR=( ❯ ❯ : )
AGKOZAK_COLORS_PROMPT_CHAR='magenta'
AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')
AGKOZAK_LEFT_PROMPT_ONLY=1
prompt agkozak-zsh-prompt
bindkey -v

export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
export SPACK_USER_CACHE_PATH=/Users/tamasgal/cache
export SPACK_DISABLE_LOCAL_CONFIG=True
