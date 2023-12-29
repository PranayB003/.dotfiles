#!/bin/bash

# references:
# https://mkyong.com/linux/cannot-set-lc_ctype-to-default-locale-no-such-file-or-directory/
# https://askubuntu.com/questions/599808/cannot-set-lc-ctype-to-default-locale-no-such-file-or-directory
sudo locale-gen "en_US.UTF-8"
sudo dpkg-  reconfigure locales

# test whether it worked
locale
