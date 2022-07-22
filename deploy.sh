#!/bin/sh

wrkdir=${PWD}
baskergit="https://github.com/baskerville"

##install using 'assume-yes'
install() {
    apt --assume-yes install "$1" >/dev/null 2>&1
}

installbspdeps() {
    echo "Installing dependencies..."
    apt --assume-yes install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev
}

maketempdir() {
    export repodir="${HOME}/.local/temp/deploy"
    mkdir -p "$repodir"
}

clonerepo() {
    echo "Cloning $1..."
    reponame="$1"
    git clone "$baskergit/${reponame%.git}" "$repodir/$reponame"
}

gitmakeinstall() {
    progname="$1"
    progpath="$repodir/$progname/"

    cd "$progpath" || exit 1
    make
    make install
    cd /tmp || return 1
}

copyfonts() {
    echo "Copying fonts..."
    mkdir ${HOME}/.local/share/fonts
    cp -r "$wrkdir/.fonts/*" ${HOME}/.local/share/fonts/
    fc-cache -f -v
}

copydots() {
    echo "Copying Wallpaper & .dot files..."
    cp -r "$wrkdir/Wallpaper" "${HOME}"
    cp -r "$wrkdir/.config" "${HOME}"
    cp -r "$wrkdir/.scripts" "${HOME}"
}

cleanup() {
    echo "Cleaning up $repodir..."
    rm -rf "$repodir"
}

##run script
#install
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

#copy configs from repo
copyfonts
copydots

#cleanup and exit
cleanup
exit 0
