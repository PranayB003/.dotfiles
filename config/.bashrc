# Apply bashrc config to all new terminals
source /etc/skel/bashrc-DEFAULT

# PATH
PATH=~/.local/bin:$PATH

# Custom PROMPT string
if [ "$ADE_VIEW_NAME" ]
then
  PS1="\[\e[33m\][ $ADE_VIEW_NAME ]\[\e[m\] \[\e[36m\]\W\[\e[32m\]\\$\[\e[m\] "
fi

# Aliases for ADE views
alias grep='grep --color'
alias clera=clear
alias ls='ls --color=auto'
if ! [ -z ${SRCHOME+x} ] 
then
  alias sqlplus='rlwrap -c sqlplus'
fi

# Convenience functions
function upstreambuild() {
  shutme -a;
  if [[ $1 == --clean ]] 
  then
     clntest -a -f; 
  fi
  ade copydb -dir $CDB_SEED -noscript;
  oratst rdbmsini cdb=true skip_pdb_seed=true auto_local_undo=true;
  startme;
}
function rebuild() {
  shutme -a;
  if [[ $1 == --clean ]] 
  then
     clntest -a -f; 
  fi
  cd rdbms;
  csh ~/setup_hcc.sh;
  tcompile -c -g -v;
  make hcc_on oracle;
  startme;
}
function lscmd() {
  if [[ $1 == ade ]] 
  then
    echo ade createview -series RDBMS_MAIN_LINUX.X64 -latest view_name
    echo ade useview view_name
    echo ade mktwork
    echo ade lsviews
    echo ade begintrans trans_name
    echo ade co file_name
    echo ade ci file_name
  fi
  if [[ $1 == compile ]]
  then 
    echo To compile specific files: recomp file.c
    echo To link recompiled files to the DB binary: link hcc_on oracle
  fi
}
