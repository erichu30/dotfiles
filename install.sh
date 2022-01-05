#!/bin/sh
sudo apt update && sudo apt install vim git curl -y

# cp .vimrc
cp tools/vim/.vimrc ~/

# install vim Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
