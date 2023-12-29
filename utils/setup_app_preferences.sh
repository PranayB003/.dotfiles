#!/bin/bash
echo $TERTIARY copying app preferences...
cp ./Library/Preferences/* ~/Library/Preferences/

# vscode
echo $TERTIARY setting up VSCode settings and keybindings...
cp ./Library/Application\ Support/Code/User/*.json ~/Library/Application\ Support/Code/User/
