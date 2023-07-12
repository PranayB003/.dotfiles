# Apply bashrc config to all new terminals
source /etc/skel/bashrc-DEFAULT

# PATH
PATH=~/.local/bin:$PATH

# Custom PROMPT string
if [ "$ADE_VIEW_NAME" ]
then
  PS1="\[\e[33m\][ $ADE_VIEW_NAME ]\[\e[m\] \[\e[36m\]\W\[\e[32m\]\\$\[\e[m\] "
fi

alias grep='grep --color'
alias clera=clear
alias ls='ls --color=auto'
if ! [ -z ${SRCHOME+x} ] 
then
  alias sqlplus='rlwrap -c sqlplus'
fi

