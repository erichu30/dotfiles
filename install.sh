#!/bin/bash

PM=""

function identifyPackageManager() {
	if [ -f "/usr/bin/apt-get" ]; then
		echo "apt-get is found"
		PM="apt-get"
	elif [ -f "/usr/bin/yum" ]; then
		echo "yum is found"
		PM="yum"
	elif [ -f "/usr/bin/brew" ]; then
		echo "brew is found"
		PM="brew"
	else
		echo "No package manager is found"
		exit 1
	fi
}

function installPackage() {
	packages="vim git curl tmux"
	for i in $packages; do
		if [ -f "/usr/bin/$i" ]; then
			echo "$i is installed"
		else
			echo "$i is not installed"
			echo "installing $i..."
			sudo $PM install $i
		fi
	done
}

function backupDotfiles() {
	targetDotfiles=".vimrc .bashrc .tmux.conf"
	for i in $targetDotfiles; do
		if [ -f "~/$i" ]; then
			echo "backup $i"
			mv ~/$i ~/$i.bak
			touch ~/$i
		fi
	done
}

function recoverDotfiles() {
	targetDotfiles=".vimrc .bashrc .tmux.conf"
	for i in $targetDotfiles; do
		if [ -f "~/$i.bak" ]; then
			echo "recover $i"
			mv ~/$i ~/$i.bak.tmp
			mv ~/$i.bak ~/$i
			mv ~/$i.bak.tmp ~/$i.bak
		fi
	done
}

function usage() {
	echo "Usage: $0 [options]"
	echo "Options:"
	echo "	-h, --help		Display this message"
	echo "	-i, --install		Install dotfiles"
	echo "	-r, --recover		recover dotfiles"
}


# if -i pass, install dotfiles
# if -r pass, recover dotfiles
# if -h pass, display usage
while [ $# -gt 0 ]; do
	case $1 in
		-i|--install)
			identifyPackageManager
			installPackage
			backupDotfiles
			;;
		-r|--recover)
			recoverDotfiles
			;;
		-h|--help)
			usage
			;;
		*)
			echo "Unknown option: $1"
			usage
			exit 1
			;;
	esac
	shift
done