# Apply bashrc config to all new terminals
source /etc/skel/bashrc-DEFAULT

# PATH
PATH=~/.local/bin:$PATH

# Custom PROMPT string
if [ "$ADE_VIEW_NAME" ]
then
  PS1="\[\e[33m\][ $ADE_VIEW_NAME ]\[\e[m\] \[\e[36m\]\W\[\e[32m\]\\$\[\e[m\] "
fi

# Convenience aliases
alias grep='grep --color'
alias ls=lsd
alias cat=bat
if ! [ -z ${SRCHOME+x} ] 
then
  alias sqlplus='rlwrap -c sqlplus'
fi

# Inlcude headers and libs installed in ~/.local
# Following 2 lines used by 'configure' scripts during installations
export LDFLAGS=-L/home/$USER/.local/lib/
export CFLAGS=-I/home/$USER/.local/include/
# Following line used to dynamically link shared library during runtime
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USER/.local/lib

export DISPLAY=:1

eval "$(starship init bash)"
