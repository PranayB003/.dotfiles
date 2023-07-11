#!/bin/bash
echo $SECONDARY "\nVerifying xcode command line tools installation"

if ! xcode-select -p 2>/dev/null; then
  # Install the xcode command line tools - xcode-select is the eaisest way.
  echo $SECONDARY "Installing XCode Command Line tools using default xcode-select"
  xcode-select --install

  # Wait for system to install the command line tools (this is to halt the
  # script until tools aren't installed).
  echo $SECONDARY "The Installation is currently in progress, Click Agree on the prompt."
  while ! xcode-select -p 2>/dev/null; do sleep 5; done

  # Verify the installation (the loop will only break when the path for the
  # tools will be found, therefore, no extra verfication needed)
  echo $TERTIARY "XCode Command line tools successfully installed."
fi
