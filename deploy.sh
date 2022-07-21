#!/bin/sh

baskergit="https://github.com/baskerville"

##install using 'assume-yes'
install() {
    apt --assume-yes install "$1" >/dev/null 2>&1
}

installbspdeps() {
    apt --assume-yes install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev
}

maketempdir() {
    export repodir="${HOME}/.local/temp/deploy"
    mkdir -p "$repodir"
}

clonerepo() {
    reponame="$1"
    git clone "$baskergit/${reponame%.git}" "$repodir/$reponame"
}

gitmakeinstall() {
    progname="$1"
    progpath="$repodir/$progname/"

    cd "$progpath" || exit 1
    make >/dev/null 2>&1
    make install >/dev/null 2>&1
    cd /tmp || return 1
}

cleanup() {
    rm -rf "$repodir"
}

##run script
maketempdir

installbspdeps

clonerepo "bspwm"

clonerepo "sxhkd"

gitmakeinstall "bspwm"

gitmakeinstall "sxhkd"

install "alacritty"

install "neovim"

install "rofi"

install "feh"

install "picom"

install "polybar"

