# Cisco Anyconnect
path+=('/opt/cisco/anyconnect/bin')
alias vpnconnect='vpn -s connect myaccess-india.oraclevpn.com < ~/.oracleVPNCredentials'
alias vc='vpnconnect'
alias vd='vpn disconnect'
alias vs='vpn state'

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# PROMPT Customisation
touch ~/.hushlogin
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%B%F{yellow}%*%f%b %F{32}%~%f %F{red}${vcs_info_msg_0_}%f%# '

# Convenience Aliases
notify() {
  echo $'\e]9;' "$*" '\007'
}
alias -g cat=bat
alias ls=exa
