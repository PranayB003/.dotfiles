# Apply bashrc config to all new terminals
source /etc/skel/bashrc-DEFAULT
# setup proxy to allow downloads from github and other places
source /usr/local/remote/oci/noarch/admin/scripts/Proxy-Config-set.sh

# PATH
PATH=~/.local/bin:$PATH

# Custom PROMPT string
if [ "$ADE_VIEW_NAME" ]
then
  PS1="\[\e[33m\][ $ADE_VIEW_NAME ]\[\e[m\] \[\e[36m\]\W\[\e[32m\]\\$\[\e[m\] "
fi

# Convenience aliases
alias bdtool='$ADE_VIEW_ROOT/rdbms/bin/bdtool'
alias grep='grep --color'
alias ls=lsd
alias cat=bat
if ! [ -z ${SRCHOME+x} ] 
then
  alias sqlplus='rlwrap -c sqlplus'
fi

# Broadcast a command to every pane in the current tmux session
tmux-sync-all() {
  if [ -z "$1" ]; then
    echo "Usage: tmux-sync-all 'your command here'"
    return 1
  fi

  # Get all pane IDs in the current session and send the command + Enter
  tmux list-panes -s -F "#{pane_id}" | xargs -I{} tmux send-keys -t {} "$*" Enter
}


# Set CSCOPE_DB for vim + cscope to be used in ade view
if [ -n ${SRCHOME+x} ]; then
export CSCOPE_DB2=${SRCHOME}/${NDE_PRODUCT}/utl/cscope.out
fi


# Include headers and libs installed in ~/.local
# Following 2 lines used by 'configure' scripts during installations
export LDFLAGS=-L/home/$USER/.local/lib/
export CFLAGS=-I/home/$USER/.local/include/
# Following line used to dynamically link shared library during runtime
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USER/.local/lib

export DISPLAY=:1
export EDITOR=nvim

eval "$(starship init bash)"
