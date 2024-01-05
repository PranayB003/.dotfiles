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
curl -OL https://golang.org/dl/go1.21.5.linux-arm64.tar.gz
sha256sum go1.21.5.linux-arm64.tar.gz
echo $SECONDARY Verify the above checksum from https://go.dev/dl/ $CLEAR
read -n1 -p "Continue installing Golang? (y/n)" doit 
case $doit in  
	y|Y) sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xvf go1.21.5.linux-arm64.tar.gz;; 
	*) echo $ERROR Skipping Golang installation $CLEAR ;; 
esac
cd ~/.dotfiles/
rm go1.21.5.linux-arm64.tar.gz
mkdir -p ~/.go
sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
sudo update-alternatives --set go /usr/local/go/bin/go
go version

# Neovim
echo -e $PRIMARY Installing Neovim $CLEAR
sudo apt install ninja-build gettext cmake unzip curl
cd ~
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
make install
cd ~/.dotfiles
nvim --version
