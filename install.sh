#!/bin/bash
echo "==========================================="
echo "Pre-request: use your own package manager to install following package" 
echo "vim git curl"
echo "==========================================="

# remove and backup the old dotfiles
# [[ -f "~/.vim" ]] && ( cp ~/.vim ~/.vim_bak ) || ( touch ~/.vim; [[ -f "~/.vim_bak" ]] && cat ~/.vim_bak >> ~/.vim )
# [[ -f "~/.vimrc" ]] && ( cp ~/.vimrc ~/.vimrc_bak ) || ( touch ~/.vimrc; [[ -f "~/.vimrc.bak" ]] && cat ~/.vimrc_bak >> ~/.vimrc )
# [[ ! -d "~/.vim" ]] && mkdir ~/.vim

echo "Check if Vundle installed or not..."

if [ -f "~/.vimrc" && grep -q "VundleVim/Vundle.vim" "~/.vimrc" ]; then 
	echo "Vundle installed"
else
	echo "Vundle is not installed"; echo "installing Vundle"; git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; echo "add config for vundle to .vimrc ..."; cat tools/vim/vundle.config >> ~/.vimrc ;echo "key in following command in terminal"; echo "vim +PluginInstall +qall"
fi

echo "Checking Done"


