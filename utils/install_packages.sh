#!/bin/bash
sudo apt update

# zsh, tmux
echo -e $PRIMARY Installing zsh, tmux $CLEAR
sudo apt install zsh tmux

# gcc, g++, make, gdb
echo -e $PRIMARY Installing gcc, g++, make, gdb $CLEAR
sudo apt install gcc g++ make
sudo apt install gdb gdb-doc

# exa, bat
echo -e $PRIMARY Installing exa, bat, btop $CLEAR
sudo apt install exa bat btop
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat

# Java
echo -e $PRIMARY Installing Java $CLEAR
sudo apt install default-jre default-jdk maven

# Golang
echo -e $PRIMARY Installing Golang $CLEAR
curl -OL https://golang.org/dl/go1.21.5.linux-amd64.tar.gz
sha256sum go1.21.5.linux-amd64.tar.gz
echo $SECONDARY Verify the above checksum from https://go.dev/dl/ $CLEAR
read -n1 -p "Continue installing Golang? (y/n)" doit 
case $doit in  
	y|Y) sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xvf go1.21.5.linux-amd64.tar.gz;; 
	*) echo $ERROR Skipping Golang installation $CLEAR ;; 
esac
cd ~/.dotfiles/
rm go1.21.5.linux-amd64.tar.gz
mkdir -p ~/.go
sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
sudo update-alternatives --set go /usr/local/go/bin/go
go version

# Neovim
curl -OL \
https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
curl -OL \
https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz.sha256sum
if [[ $(sha256sum nvim-linux64.tar.gz) == $(cat nvim-linux64.tar.gz.sha256sum) ]]
then
  echo -e $TERTIARY Neovim checksum matched $CLEAR
  sudo rm -rf /usr/local/nvim-linux64 && sudo tar -C /usr/local -xzvf nvim-linux64.tar.gz;
fi
cd ~/.dotfiles/
rm nvim-linux64.tar.gz nvim-linux64.tar.gz.sha256sum
ln -sf /usr/local/nvim-linux64/bin/nvim ~/.local/bin/nvim
nvim --version
