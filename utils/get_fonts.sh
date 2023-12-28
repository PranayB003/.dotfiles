#!/bin/bash

curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.tar.xz
sudo tar -C /usr/local/share/fonts -xvf Hack.tar.xz
cd ~/.dotfiles
rm Hack.tar.xz


