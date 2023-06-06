# Import variables for colored output
source ./assets/colors.sh 

# Install xcode command line tools
sh ./utils/get_xcode.sh

# Install Homebrew
sh ./utils/get_brew.sh

# Install Homebrew formulae and casks
sh ./utils/install_packages.sh

# Make symlinks for all dotfiles
sh ./utils/setup_symlinks.sh $PWD/config ~

# Copy preferences for apps
sh ./utils/setup_app_preferences.sh
