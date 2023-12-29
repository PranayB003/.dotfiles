#!/bin/bash
mkdir Fonts
cd Fonts

curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
unzip Hack.zip -d ./Hack
cp -R ./Hack/ ~/Library/Fonts/

cd ..


