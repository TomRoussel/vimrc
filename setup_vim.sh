#!/usr/bin/env bash

if [[ ! -d ~/.vim ]]; then
	echo "Could not find ~/.vim, did you forget to rename the repo after cloning it?"
	echo "Quitting"
	exit 1
fi

if [[ -f ~/.vimrc ]]; then
	echo "~/.vimrc already exists! Please remove this manually"
	exit 1
fi

echo "source ~/.vim/custom_rc" >> ~/.vimrc

cd ~/.vim

git submodule update --init

mkdir swap
mkdir undo
mkdir backup

