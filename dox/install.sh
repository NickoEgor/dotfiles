#!/bin/bash

### dop section
> install vifm highlight
> install configs
> install vifmrun
###

# TODO
## create user
## install git curl
## fd-find fzf

mkdir -pv ~/prog
mkdir -pv ~/.config
mkdir -pv ~/.local/{bin/,share/}

pushd prog
git clone http://github.com/NickoEgor/dotfiles
git clone http://github.com/NickoEgor/dwm
git clone http://github.com/NickoEgor/dmenu
git clone http://github.com/NickoEgor/st
git clone --raw http://github.com/NickoEgor/dotfiles df

# install polybar with dwm
git clone https://github.com/mihirlad55/polybar-dwm-module

sudo dnf install \
    gcc gcc-c++ \
    cairo-devel wireless-tools-devel python3 \
    libxcb-devel xcb-proto xcb-util xcb-util-wm-devel xcb-util-devel \
    xcb-util-cursor-devel xcb-util-xrm-devel xcb-util-image-devel \
    jsoncpp-devel
./build.sh -d -i -j -f -n -A

popd

# TODO
# install deps -> build dwm/dmenu/st
# install x11 utils
> sudo dnf install xset xsetroot xorg-x11-server-utils
# install xwallpaper
> sudo dnf copr enable linuxredneck/xwallpaper
> sudo dnf install xwallpaper
# install libXft-bgra
sudo rpm --nodeps -e libXft libXft-devel
sudo dnf install libXft-bgra-devel --allowerasing
###

# update user dirs
mkdir ~/{dox,pix,vids,music}
rmdir ~/{Documents,Pictures,Videos,Music}

cp -v ~/prog/dotfiles/.config/user-dirs.dirs ~/
xdg-user-dirs-update
###

# setup bash
cp -v ~/prog/dotfiles/.bashrc ~/
cp -v ~/prog/dotfiles/.config/inputrc ~/.config/
###

# setup zsh
# install zsh zsh-autosuggestions
chsh -s /usr/bin/zsh yahor
mkdir -pv ~/.config/zsh/
cp -v ~/prog/dotfiles/.config/zsh/.zshrc ~/.config/zsh/
###

# setup profile
cp -v ~/prog/dotfiles/{.profile,.zprofile} ~/.config/zsh/
###

# setup session
sudo dnf install xorg-x11-xinit xorg-x11-xinit-session
cp -v ~/prog/dotfiles/{.xinitrc,.xsession}
sudo mkdir -pv /usr/share/xsessions/
sudo cp -v ~/prog/dotfiles/.local/external/custom.desktop /usr/share/xsessions/
###

# setup git
git config --global credential.helper store
ssh -vT git@github.com
###

# setup tmux 
# install tmux
cp -v ~/prog/dotfiles/.tmux.conf ~/
###

# install some scripts
cp -v ~/prog/dotfiles/.local/bin/{powermanager,emojis,compiler} ~/.local/bin/
###

# install gtk themes
sudo apt install arc-theme
cp ~/prog/dotfiles/.config/gtk-2.0/gtkrc-2.0 ~/.config
cp ~/prog/dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/
###

# install dragon
sudo apt install libgtk-3-dev
git clone https://github.com/mwh/dragon.git
cd dragon
make install
###

# install dunst
mkdir -pv ~/.config/dunst
cp ~/prog/dotfiles/.config/dunst/dunstrc ~/.config/dunst/
sudo apt install dunst
###

# TODO: add installation modules:
# vifm, WM (dunst/powermanager/Xresources/picom/polybar/sxhkd/dragon/env-wrapper/xinitrc/xsession)
