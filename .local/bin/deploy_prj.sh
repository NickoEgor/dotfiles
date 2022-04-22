#!/bin/bash

mkdir -pv .nvim

echo '# TODO' > .nvim/TODO.md
echo '" vim: fdm=marker fdl=0' > .nvim/init.vim

default_files="$HOME/.config/ide"
[ ! -d "$default_files" ] && echo "default files not found" && exit

[ -f "$default_files/Makefile" ] && cp ~/.config/ide/Makefile .nvim
[ -f "$default_files/ycm.py" ] && ln -s ~/.config/ide/ycm.py .nvim/
