#!/bin/bash
[ ! -f "`which brew`" ] && /bin/bash -c "$(curl -fsSL \
https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
|| brew update && echo $SECONDARY "$(brew --version | head -1) is already \
installed."
