# Custom PROMPT string
PS1="\[\e[32m\][\[\e[m\]\[\e[1;31m\]\u\[\e[m\]\[\e[1;33m\]@\[\e[m\]\[\e[1;31m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] "

# Environment variables
VISUAL=$(which vim)
EDITOR=$(which vi)

source /usr/local/remote/oci/noarch/admin/scripts/Proxy-Config-set.sh

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi
