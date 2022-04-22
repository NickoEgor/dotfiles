#!/bin/sh

# path
export GOPATH="$HOME/prog/go"
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/specific:$GOPATH/bin"

# programs
export SHELL="/bin/bash"
# export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export READER="zathura"
# export WM="dwm"

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
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# program settings
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export LESSHISTFILE="-"
export MERGETOOL="nvim -d"
export SYSTEMD_PAGES=less
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
# export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
# export MANPATH="$MANPATH:$XDG_DATA_HOME/man:$XDG_CACHE_HOME/cppman/cppreference.com"
# export PYLINTHOME="$XDG_CACHE_HOME/pylint"
# export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc.py"
# export RANDFILE="$XDG_CACHE_HOME/rnd"
# export R_PROFILE_USER="$XDG_CONFIG_HOME/Rprofile"
# export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
# export SXHKD_SHELL="/bin/bash"
# export TS_SLOTS=3
# export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" ## NOTE: do not use with gdm, bc it breaks login

if [ "$(tty)" = "/dev/tty1" ] && [ -n "$WM" ]; then
	pgrep -x "$WM" || exec startx 1>/dev/null 2>/dev/null
fi
