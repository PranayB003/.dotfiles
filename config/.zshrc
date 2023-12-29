# PROMPT Customisation
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%B%F{yellow}%*%f%b %F{32}%~%f %F{red}${vcs_info_msg_0_}%f%# '

# Convenience Aliases
alias -g cat=bat
alias ls=exa
alias -g grep='grep --color=auto'

# "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Functions
gcdate() { # use a specific commit date and author date while making a commit
  if [ -n "$1" ]
  then
    GIT_COMMITTER_DATE="$1" git commit --date "$1" $@[2,$#];
  else
    echo 'Usage: gcdate "date-time" [other-git-commit-options]';
    echo Example: gcdate '"Mon 20 Aug 2018 20:19:19 IST"';
  fi
}
