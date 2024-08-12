#!/bin/bash
curl -OL \
https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
curl -OL \
https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz.sha256sum
if [[ $(sha256sum nvim-linux64.tar.gz) == $(cat nvim-linux64.tar.gz.sha256sum) ]]
then
    echo -e $TERTIARY Neovim checksum matched $CLEAR
    rm -rf ~/.local/nvim-linux64 && tar -C ~/.local/ -xzvf nvim-linux64.tar.gz;
fi
cd ~/.dotfiles/
rm nvim-linux64.tar.gz nvim-linux64.tar.gz.sha256sum
ln -sf ~/.local/nvim-linux64/bin/nvim ~/.local/bin/nvim
nvim --version
