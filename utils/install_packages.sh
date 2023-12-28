#!/bin/bash
sudo apt update

# zsh, neovim
echo -e $PRIMARY Installing zsh, neovim, tmux $CLEAR
sudo apt install zsh neovim tmux

# gdb
echo -e $PRIMARY Installing gdb $CLEAR
sudo apt install gdb gdb-doc

# exa, bat
echo -e $PRIMARY Installing exa, bat, btop $CLEAR
sudo apt install exa bat btop
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Java
echo -e $PRIMARY Installing Java $CLEAR
sudo apt install default-jre default-jdk

# Golang
echo -e $PRIMARY Installing Golang $CLEAR
curl -OL https://golang.org/dl/go1.21.5.linux-amd64.tar.gz
sha256sum go1.21.5.linux-amd64.tar.gz
echo $SECONDARY Verify the above checksum from https://go.dev/dl/ $CLEAR
read -n1 -p "Continue installing Golang? (y/n)" doit 
case $doit in  
	y|Y) sudo tar -C /usr/local -xvf go1.21.5.linux-amd64.tar.gz;; 
	*) echo $ERROR Skipping Golang installation $CLEAR ;; 
esac
cd ~/.dotfiles/
rm go1.21.5.linux-amd64.tar.gz
mkdir ~/.go
sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
sudo update-alternatives --set go /usr/local/go/bin/go
go version
