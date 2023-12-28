#!/bin/bash

# Grant execution permissions for scripts in ./utils
chmod -R 777 ./utils/

# Import variables for colored output
source ./assets/colors.sh 

# Install custom fonts (e.g. Nerd Fonts which have icons)
./utils/get_fonts.sh

# Install cmd line utilities and programs
./utils/install_packages.sh

# Install vim theme
./utils/install_misc_packages.sh

# Make symlinks for all dotfiles
./utils/setup_symlinks.sh $PWD/config ~

# Change default login shell to zsh
sudo chsh -s zsh
