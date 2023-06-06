#!/bin/bash

# This function accepts two parameters:
# First param (source_base): the absolute path of the directory from where all
# files should be recursively symlinked.
# Second param (dest_base): The base directory for the resulting symlinks
# Symlinks source_base/.../source_file --> dest_base/.../destination
function linkFiles () {
  # Loop through all the contents of source directory
  for path in "$1"/\.* "$1"/*; do
    if [[ "$path" == "$1"/\. || "$path" == "$1"/\.\. ]]; then
      # Ignore ./ and ../
      :;
    elif [[ -f "$path" ]]; then # 'path' is a file
      if ! [[ -d "$2" ]]; then
        # destination directory doesn't exist, create it
        mkdir -p "$2"
      fi
      ln -is "$path" $2${path#"$1"} 
    elif [[ -d "$path" ]]; then # 'path' is a directory
      linkFiles ${path} $2${path#"$1"}
    fi
  done
}

linkFiles $1 $2
