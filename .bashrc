#!/bin/bash
# This file runs every time you open a new terminal window.

# Set vi-mode
set -o vi

# Limit number of lines and entries in the history.
export HISTFILESIZE=50000
export HISTSIZE=50000

# Add a timestamp to each command.
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Duplicate lines and lines starting with a space are not put into the history.
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Ensure $LINES and $COLUMNS always get updated.
shopt -s checkwinsize

# Enable bash completion.
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Improve output of less for binary files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load aliases if they exist.
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "${HOME}/.aliases.local" ] && source "${HOME}/.aliases.local"

# Determine git branch.
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Enable asdf to manage various programming runtime versions.
#   Requires: https://asdf-vm.com/#/

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias see="explorer.exe"
alias pip="pip3"
alias python="python3"
alias vim="nvim"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
# Add go to path
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/roland/go/bin
export PATH=$PATH:/home/rolzy/.local/bin
export VISUAL=nvim
export EDITOR="$VISUAL"

# Colorize ls output
alias ls='ls --color'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias la='ls -d .* --color=auto'

alias gs='git status'
alias push='git push'
alias pull='git pull'
alias sa='source env/bin/activate'

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

ga() {
    option=${2:-''}
    [ -z "$option" ] && git add "$1" || git add "$1" "$option"
}

gcm() { git commit -m "$1"; }

gd() { git diff "$1"; }

vimpy() {
    nohup jupyter qtconsole > /dev/null 2>&1 &
    sleep 2
    tmp=$(xdotool search --onlyvisible --name jupyter)
    xdotool windowsize $tmp 960 1080
    xdotool windowmove $tmp 960 30
    nvim $1
}
