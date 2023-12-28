#!/bin/bash
# Install package manager for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins for vim
git clone git@github.com:christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator

# Install themes for vim
git clone https://github.com/akiicat/vim-github-theme.git
mkdir -p ~/.vim/colors 
mv ./vim-github-theme/colors/*.vim ~/.vim/colors/
rm -rf ./vim-github-theme
