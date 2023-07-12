# Import variables for colored output
source ./assets/colors.sh 

# Install xcode command line tools
sh ./utils/get_xcode.sh

# Install Homebrew
sh ./utils/get_brew.sh

# Install Homebrew formulae and casks
sh ./utils/install_brew_packages.sh

# Install custom fonts (e.g. Nerd Fonts which have icons)
sh ./utils/get_fonts.sh

# Make symlinks for all dotfiles
sh ./utils/setup_symlinks.sh $PWD/config ~

# Copy preferences for apps
sh ./utils/setup_app_preferences.sh

# Install vim theme
sh ./utils/install_vim_theme.sh
