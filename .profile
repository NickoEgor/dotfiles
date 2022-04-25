#!/bin/sh

# programs
export SHELL="/bin/zsh"
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export READER="zathura"

# custom
export WM="dwm"
export WMBAR="dwmbar"
export IDE_DIR=".ide"

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# history
export HISTFILE="$XDG_DATA_HOME/shell.hist"
export HISTSIZE=1000000
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE=' *'
export SAVEHIST=$HISTSIZE

# colors
export GREP_COLOR="1;31"
export LESS='-RFMx4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# settings
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export GOPATH="$HOME/prog/go"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export LESSHISTFILE="-"
export MANPATH="$MANPATH:$XDG_DATA_HOME/man:$XDG_CACHE_HOME/cppman/cppreference.com"
export MERGETOOL="nvim -d"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylintrc"
export RANDFILE="$XDG_CACHE_HOME/rnd"
export SYSTEMD_PAGER="less"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export VIMINIT="source $XDG_CONFIG_HOME/nvim/init.vim"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# path
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/user:$GOPATH/bin"

# login autostart
if [ -f "$XDG_CONFIG_HOME/autostart/on_login.sh" ]; then
    source "$XDG_CONFIG_HOME/autostart/on_login.sh"
fi

# x11 start
if [ "$(tty)" = "/dev/tty1" ] && [ -n "$WM" ]; then
    pgrep -x "$WM" || exec startx \
        1>"$XDG_CACHE_HOME/Xorg.1.log" \
        2>"$XDG_CACHE_HOME/Xorg.2.log"
fi
