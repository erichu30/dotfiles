#!/bin/bash

# identify package manager
if [ -f "/usr/bin/apt-get" ]; then
	echo "apt-get is found"
	PM="apt-get"
elif [ -f "/usr/bin/yum" ]; then
	echo "yum is found"
	PM="yum"
elif [ -f "/usr/bin/pacman" ]; then
	echo "pacman is found"
	PM="pacman"
else
	echo "No package manager is found"
	exit 1
fi

# install vim
echo "installing vim..."
sudo $PM install vim

# install git
echo "installing git..."
sudo $PM install git

# install curl
echo "installing curl..."
sudo $PM install curl

# backup old dotfiles
echo "backup old dotfiles..."

if [ -f "~/.vimrc" ]; then
	echo "backup .vimrc"
	mv ~/.vimrc ~/.vimrc.bak
fi

if [ -f "~/.bashrc" ]; then
	echo "backup .bashrc"
	mv ~/.bashrc ~/.bashrc.bak
fi


# install tmux
echo "installing tmux..."
sudo $PM install tmux



