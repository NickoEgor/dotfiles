#!/bin/bash

set -e

# TODO: screenshot (maim), clipboard (greenclip/xclip/xsel/etc) libxft-bgra, ripgrep, mpd/ncmpcpp
# NOTE: X11 dependencies
# yum (centos 7): libXft-devel libXtst-devel gtk3-devel

log2() {
    echo "==> $1" 1>&2
}

check_args() {
    target="$1"

    [ "$#" -lt 1 ] && log2 "target is needed" && exit 1
    # shellcheck disable=SC2076
    [[ ! " ${progs[*]} " =~ " $target " ]] && log2 "program is not supported" && exit 1

    return 0
}

set_prog_params() {
    # set repo
    case "$target" in
        htop-vim)   repo="https://github.com/KoffeinFlummi/htop-vim.git" ;;
        fzf)        repo="https://github.com/junegunn/fzf.git" ;;
        ctags)      repo="https://github.com/universal-ctags/ctags.git" ;;
        zsh-as)     repo="https://github.com/zsh-users/zsh-autosuggestions.git" ;;
        zsh-fsh)    repo="https://github.com/zdharma-continuum/fast-syntax-highlighting" ;;
        xwallpaper) repo="https://github.com/stoeckmann/xwallpaper.git" ;;
        acpilight)  repo="https://gitlab.com/wavexx/acpilight.git" ;;
        *)          repo="https://github.com/NickoEgor/$target.git" ;;
    esac

    # set branch
    case "$target" in
        st)         branch="patched-config" ;;
        dwm)        branch="config-bar" ;;
        xmouseless) branch="patched" ;;
        *)          branch="master" ;;
    esac
}

set_upstream() {
    if git remote -v | grep -qm1 upstream ; then
        log2 "skip set_upstream()"
        return 0
    fi

    case "$target" in
        st)         upstream="https://git.suckless.org/st" ;;
        dmenu)      upstream="https://git.suckless.org/dmenu" ;;
        dwm)        upstream="https://git.suckless.org/dwm" ;;
        dragon)     upstream="https://github.com/mwh/dragon" ;;
        xmouseless) upstream="https://github.com/jbensmann/xmouseless" ;;
        sshrc)      upstream="https://github.com/cdown/sshrc" ;;
        *)          log2 "skip set_upstream()" && return ;;
    esac

    git remote add upstream "$upstream"
}

clone_repo() {
    [ ! -d "$env_dir" ] && mkdir -p "$env_dir"
    cd "$env_dir" || exit 1

    if [ -d "$target" ]; then
        cd "$target" || exit 1
        log2 "skip clone_repo()"
        git pull
        return
    fi

    git clone "$repo" "$target"
    cd "$target" || exit 1

    git pull
    git submodule update --init --recursive

    git checkout "$branch"
}

setup_repo() {
    if [[ "$repo" == *"NickoEgor"* ]]; then
        git remote set-url origin "git@github.com:NickoEgor/$target.git"

        git config user.name "$git_name"
        git config user.email "$git_email"

        set_upstream
    fi
}

build_target() {
    case "$target" in
        st|dmenu|dwm|dwmbar|dragon|xmouseless) make ;;
        htop-vim|ctags|xwallpaper) ./autogen.sh && ./configure && make ;;
        *) log2 "skip build_target()" ;;
    esac
}

install_target() {
    case "$target" in
        st|dmenu|dwm|dwmbar|xmouseless|htop-vim|sshrc|ctags|xwallpaper|acpilight) sudo make install ;;
        dragon) sudo make PREFIX="/usr/local" install ;;
        fzf) ./install --xdg --key-bindings --no-update-rc --completion ;;
        zsh-as)
            local zsh_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
            mkdir -pv "$zsh_data_dir"
            cp ./zsh-autosuggestions.zsh "$zsh_data_dir/zsh-autosuggestions.zsh"
            ;;
        zsh-fsh)
            local zsh_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
            mkdir -p "$zsh_data_dir"
            ln -s "$PWD" "$zsh_data_dir/fsh"
            ;;
        *) log2 "skip install_target()" ;;
    esac
}

cleanup() {
    case "$target" in
        st|dmenu|dwm|dwmbar|dragon|xmouseless|htop-vim|xwallpaper) make clean ;;
        *) log2 "skip cleanup()" ;;
    esac
}

# ===================================== #

progs=(st dmenu dwm dwmbar dotfiles df dragon xmouseless term-theme
       htop-vim sshrc fzf ctags zsh-as zsh-fsh xwallpaper acpilight)
env_dir="$HOME/prog/env"

git_name="NickoEgor"
git_email="egor1998nick@gmail.com"

target=
repo=
branch=

# ===================================== #

check_args "$@"
set_prog_params
clone_repo
setup_repo
build_target
install_target
cleanup
