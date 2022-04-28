#!/bin/bash

[[ $- == *i* ]] || exit

# disable Ctrl-R freeze
stty -ixon

# prompt
blue='\e[34m'
bold='\e[1m'
default='\e[39;0m'
green='\e[32m'
magenta='\e[35m'
red='\e[31m'
yellow='\e[33m'
PS1="\[$bold$red\][\[$yellow\]\u\[$green\]@\[$blue\]\h \[$magenta\]\W\[$red\]]\[$default\]\$ "

# simple prompt
# PS1='\[\033[1;34m\][\u@\h \W]\$ \[\033[0m\]'

# options
set -o vi
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s direxpand
bind TAB:menu-complete
bind 'set show-all-if-ambiguous on'
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# aliases
[ -f "$XDG_CONFIG_HOME/shell/aliases.sh" ] && source "$XDG_CONFIG_HOME/shell/aliases.sh"
# extra settings (for temporary purposes)
[ -f "$XDG_CONFIG_HOME/shell/extra.sh" ] && source "$XDG_CONFIG_HOME/shell/extra.sh"
# fzf
[ -f "$XDG_CONFIG_HOME/fzf/fzf.bash" ] && source "$XDG_CONFIG_HOME/fzf/fzf.bash"
