#!/bin/bash

sudo sed 's/\(auth[\t ]\+\)required\([\t ]\+pam_shells.so\)/\1sufficient\2/g' \
  -i /etc/pam.d/chsh
sudo chsh $USER -s $(which $1)
sudo sed 's/\(auth[\t ]\+\)sufficient\([\t ]\+pam_shells.so\)/\1required\2/g' \
  -i /etc/pam.d/chsh
