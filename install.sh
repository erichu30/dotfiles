#!/bin/sh
sudo apt update && sudo apt install vim git curl 

# remove and backup the old dotfiles
mv  ~/.vim ~/.vim-old
mv ~/.vimrc ~/.vimrc
mkdir ~/.vim

# cp .vimrc
cp tools/vim/.vimrc ~/

# install vim Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
