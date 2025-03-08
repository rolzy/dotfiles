################################################################################
#                                                                              #
#                              INITIALIZATION                                  #
#                                                                              #
################################################################################

# Set the directory where we store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "$ZINIT_HOME/zinit.zsh"

################################################################################
#                                                                              #
#                                  PROMPT                                      #
#                                                                              #
################################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add in Powerlevel 10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################################################################################
#                                                                              #
#                                  LOOKS                                       #
#                                                                              #
################################################################################

# Enable 256 colors
export TERM="xterm-256color"

################################################################################
#                                                                              #
#                                 PLUGINS                                      #
#                                                                              #
################################################################################

# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Auto completions
zinit light zsh-users/zsh-completions

# Auto suggestions
zinit light zsh-users/zsh-autosuggestions

# fzf completions
zinit light Aloxaf/fzf-tab

################################################################################
#                                                                              #
#                                  ALIASES                                     #
#                                                                              #
################################################################################

alias ls='ls --color=auto'
alias c="clear"
alias pip="pip3"
alias python="python3"
alias vim="nvim"
alias gs='git status'
alias push='git push'
alias pull='git pull'
alias sa='source env/bin/activate'
alias cri='sudo config-rio.sh -n internal'
alias cre='sudo config-rio.sh -n external'

# The git add function
ga() {
    option=${2:-''}
    [ -z "$option" ] && git add "$1" || git add "$1" "$option"
}

# gcm for git commit -m
gcm() { git commit -m "$1"; }

# gd for git diff
gd() { git diff "$1"; }

################################################################################
#                                                                              #
#                                  SNIPPETS                                    #
#                                                                              #
################################################################################

zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found

################################################################################
#                                                                              #
#                              AUTO COMPLETION                                 #
#                                                                              #
################################################################################

# Load completions
autoload -U compinit && compinit

# Replay all cached completions
zinit cdreplay -q

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Use colors from LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 

# Disable default menu completion to use fzf-tab instead
zstyle ':completion:*' menu no                          

# cd preview during auto completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

################################################################################
#                                                                              #
#                              AUTO SUGGESTIONS                                #
#                                                                              #
################################################################################

# History settings.
HISTFILE=~/.zsh_history
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
HISTSIZE=50000               # History lines stored in memory.
SAVEHIST=50000               # History lines stored on disk.
HISTDUP=erase                # Erase duplicates in the history file.
setopt appendhistory         # Immediately append commands to history file.
setopt sharehistory          # Share history between all sessions.
setopt hist_ignore_space     # Ignore commands that start with a space.
setopt hist_ignore_all_dups  # Remove all duplicates from history.
setopt hist_save_no_dups     # Don't save duplicates in history.
setopt hist_ignore_dups      # Ignore duplicates in history.
setopt hist_find_no_dups     # Don't display duplicates when searching history.

################################################################################
#                                                                              #
#                                KEYBINDINGS                                   #
#                                                                              #
################################################################################

bindkey '^F' autosuggest-accept      # Use CTRL-F to accept auto-suggestions
bindkey -v                           # Enable vi mode

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

################################################################################
#                                                                              #
#                                 ENV VARS                                     #
#                                                                              #
################################################################################

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

# Check if running under WSL
if [[ "$(uname -r)" == *Microsoft* || "$(uname -r)" == *microsoft* ]]; then
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
    export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
    export BROWSER=wslview
fi

# If .env file exists in the home directory, use that to set API key variables
if [[ -f ~/.env ]]; then
    set -a
    source ~/.env
    set +a
fi

################################################################################
#                                                                              #
#                              OTHER SETTINGS                                  #
#                                                                              #
################################################################################

eval "$(fzf --zsh)" # Enable fzf integration

# Configure FZF.
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"

# zsh-autosuggestions settings.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
