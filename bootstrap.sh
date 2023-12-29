#!/bin/bash

# Grant execution permissions for scripts in ./utils
chmod -R 777 ./utils/

# Import variables for colored output
source ./assets/colors.sh 

# Install xcode command line tools
./utils/get_xcode.sh

# Install Homebrew
./utils/get_brew.sh

# Install Homebrew formulae and casks
./utils/install_brew_packages.sh

# Install custom fonts (e.g. Nerd Fonts which have icons)
./utils/get_fonts.sh

# Make symlinks for all dotfiles
./utils/setup_symlinks.sh $PWD/config ~

# Copy preferences for apps
./utils/setup_app_preferences.sh

# Install vim theme
./utils/install_misc_packages.sh
