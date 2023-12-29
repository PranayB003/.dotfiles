# Dotfiles Repository
A collection of shell scripts to setup a macOS system with my preferred vim, tmux, terminal etc. configurations and system preferences.

## Installation
First, clone the repository (preferably in the home directory).
```shell
cd ~
git clone https://github.com/PranayB003/.dotfiles.git ./.dotfiles
cd ./.dotfiles
```

On a new system, things can be setup from scratch using the bootstrap script:
```shell
chmod 777 ./bootstrap.sh
./bootstrap.sh
```

On systems that already have part of the setup complete, individual scripts from `/utils` can be used. Note that you must be in the `.dotfiles` directory while executing any of these scripts.\
Example:
```shell
# Run only once, to grant execution permission for all scripts in utils/
chmod -R 777 ./utils/
./utils/setup_symlinks.sh
```
