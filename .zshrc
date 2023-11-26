# Uncomment this to time the processes
#zmodload zsh/zprof

# Load colors so we can access $fg and more.
autoload -U colors && colors

git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | rev | cut -d '/' -f1 | rev)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " (${branch})"
}
setopt PROMPT_SUBST
PROMPT='%B%{$fg[green]%}%n %{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '


# History settings.
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000        # History lines stored in mememory.
export SAVEHIST=50000        # History lines stored on disk.
setopt INC_APPEND_HISTORY    # Immediately append commands to history file.
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

# Use modern completion system. Other than enabling globdots for showing
# hidden files, these ares values in the default generated zsh config.
autoload -U compinit
compinit
_comp_options+=(globdots)

zstyle ':completion:*' menu select=2
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

# dircolors is a GNU utility that's not on macOS by default. With this not
# being used on macOS it means zsh's complete menu won't have colors.
#command -v dircolors > /dev/null 2>&1 && eval "$(dircolors -b)"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

### Vi-mode ###
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

### ALIASES ###
alias pip="pip3"
alias python="python3"
alias vim="nvim"
alias ls='ls --color'
alias gs='git status'
alias push='git push'
alias pull='git pull'
alias sa='source env/bin/activate'
alias cri='sudo config-rio.sh -n internal'
alias cre='sudo config-rio.sh -n external'
alias cpi='sudo config-proxy.sh -n internal'
alias cpe='sudo config-proxy.sh -n external'
alias gpt='sgpt'
alias code='/mnt/c/Users/roland.thompson/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'

ga() {
    option=${2:-''}
    [ -z "$option" ] && git add "$1" || git add "$1" "$option"
}

gcm() { git commit -m "$1"; }

gd() { git diff "$1"; }

### ZPLUG ###

source ~/.zplug/init.zsh
touch $ZPLUG_LOADFILE

# vim-mode
zplug "jeffreytse/zsh-vi-mode"

# syntax highlighting
zplug "zdharma/fast-syntax-highlighting"

# autosuggestions
zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Auto Suggestion 
bindkey '^F' autosuggest-accept

# Configure FZF.
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"

# zsh-autosuggestions settings.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Enable FZF 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^r' fzf-history-widget
export TERM="xterm-256color"
export PYENV_ROOT="$HOME/.pyenv"
export YARN_ROOT="$HOME/.yarn"
export PATH="$PYENV_ROOT/bin:$YARN_ROOT/bin:$HOME/.local/bin:/opt/mssql-tools/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

eval $(thefuck --alias f)
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export BROWSER=wslview

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# If .env file exists in the home directory, use that to set API key variables
[ -f ~/.env ] && source ~/.env
