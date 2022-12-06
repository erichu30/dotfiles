#!/bin/bash
echo "sudo apt update && sudo apt install vim git curl"

# remove and backup the old dotfiles
[[ -f "~/.vim" ]] && ( cp ~/.vim ~/.vim_bak ) || ( touch ~/.vim; [[ -f "~/.vim_bak" ]] && cat ~/.vim_bak >> ~/.vim )
[[ -f "~/.vimrc" ]] && ( cp ~/.vimrc ~/.vimrc_bak ) || ( touch ~/.vimrc; [[ -f "~/.vimrc.bak" ]] && cat ~/.vimrc_bak >> ~/.vimrc )
#[[ ! -d "~/.vim" ]] && mkdir ~/.vim

# add config to .vimrc for vundle
cat tools/vim/vundle.config >> ~/.vimrc

# install vim Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "vim +PluginInstall +qall"
