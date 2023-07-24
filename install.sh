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
	targetDotfiles=".bashrc .vimrc .tmux.conf"
	for i in $targetDotfiles; do
		if [ -f "~/$i" ]; then
			echo "backup $i"
			mv ~/$i ~/$i.bak
			touch ~/$i
		fi
	done
}

function recoverDotfiles() {
	targetDotfiles=".bashrc .vimrc .tmux.conf"
	for i in $targetDotfiles; do
		if [ -f "~/$i.bak" ]; then
			echo "recover $i"
			mv ~/$i ~/$i.bak.tmp
			mv ~/$i.bak ~/$i
			mv ~/$i.bak.tmp ~/$i.bak
		fi
	done
}

function setupBash-it() {
	# install bash-it
	if [ -d "~/.bash_it" ]; then
		echo "bash-it is installed"
	else
		git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
		y | ~/.bash_it/install.sh
	fi
	
	source ~/.bashrc

	echo "===================="
	echo "use bash-it command to manage bash-it: "
	echo "bash-it show aliases"
	echo "bash-it show completion"
	echo "bash-it show plugins"
	echo "bash-it show themes"
	echo "===================="
	
	defaultAlias="clipboard ansible curl systemd general git tmux vim docker"
	defaultCompletion="tmux ssh pip3 pip git export docker brew"
	defaultPlugin="docker edit-mode-vi extract git history less-pretty-cat postgres pyenv python ssh tmux virtualenv xterm z_autoenv"
	
	for i in $defaultApp; do
		bash-it enable alias $i
	done

	for i in $defaultCompletion; do
		bash-it enable completion $i
	done

	for i in $defaultPlugin; do
		bash-it enable plugin $i
	done
}

function setupVim() {
	# # install vundle
	# git clone 
	echo "===================="
}

DEVSHELL=""
DEVSHELLRC=""
function setupDevShell() {
	# ask user to choose dev shell
	echo "Choose your dev shell:"
	echo "1. bash"
	echo "2. zsh"
	echo "3. sh"

	read -p "Enter your choice: " choice

	case $choice in
		1)
			DEVSHELL="bash"
			DEVSHELLRC=".bashrc"
			;;
		2)
			DEVSHELL="zsh"
			DEVSHELLRC=".zshrc"
			;;
		3)
			DEVSHELL="sh"
			DEVSHELLRC=".shrc"
			;;
		*)
			echo "Unknown choice"
			exit 1
			;;
	esac
}

function setupTmux() {
	echo "===================="

	# # install tpm
	# git clone

	# # install tmux plugins
	# tmux source-file ~/.tmux.conf

	# # install tmuxinator
	# gem install tmuxinator

	# # install tmuxinator completion base on dev shell and dev shell rc
}

function tatSetup() {
	# echo multiple lines into dev shell rc
	cat >> ~/$DEVSHELLRC << EOF
function tat {
	name=$(basename `pwd` | sed -e 's/\.//g')

	if tmux ls 2>&1 | grep "$name"; then
		tmux attach -t "$name"
	elif [ -f .envrc ]; then
		direnv exec / tmux new-session -s "$name"
	else
		tmux new-session -s "$name"
	fi
}
EOF
}

function setupAll() {
	setupDevShell
	setupTmux
	setupVim
	tatSetup
	setupBash-it
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
			setupAll
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