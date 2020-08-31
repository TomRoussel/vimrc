#!/usr/bin/env bash

function check_bin() {
    if type $1 2>&1 >/dev/null ; then
        echo "$1 is installed"
    else
        echo "WARNING: $1 should be installed, some stuff might not work"
    fi
}

if [[ ! -d ~/.vim ]]; then
	echo "Could not find ~/.vim, did you forget to rename the repo after cloning it?"
	exit 1
fi

echo "Checking some dependencies..."
check_bin ack
check_bin git
check_bin fzf
check_bin ag

if [[ -f ~/.vimrc ]]; then
	echo "~/.vimrc already exists! Please remove this manually"
	exit 1
fi

echo "source ~/.vim/customrc.vim" >> ~/.vimrc

cd ~/.vim

mkdir swap
mkdir undo
mkdir backup

vim +PlugInstall +qall
