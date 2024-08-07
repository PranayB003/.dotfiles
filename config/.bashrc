# PATH
PATH=~/.local/bin:$PATH

# Custom PROMPT string
if [ "$ADE_VIEW_NAME" ]
then
  PS1="\[\e[33m\][ $ADE_VIEW_NAME ]\[\e[m\] \[\e[36m\]\W\[\e[32m\]\\$\[\e[m\] "
fi

alias grep='grep --color'
alias ls=lsd
alias cat=bat
if ! [ -z ${SRCHOME+x} ] 
then
  alias sqlplus='rlwrap -c sqlplus'
fi

eval "$(starship init bash)"
