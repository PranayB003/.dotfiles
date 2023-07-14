# homebrew aliases
if [[ -e /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)" 
fi

# allow usage of 'brew desc' without the --eval-all flag
HOMEBREW_EVAL_ALL=1
