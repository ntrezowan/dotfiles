# HISTORY
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST="$HISTSIZE"
setopt extended_history
setopt inc_append_history
setopt inc_append_history_time
setopt share_history
setopt hist_fcntl_lock
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store

# MAN COLORS
man() {
  GROFF_NO_SGR=1 \
  LESS_TERMCAP_mb=$'\e[31m' \
  LESS_TERMCAP_md=$'\e[34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[1;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[35m' \
  command man "$@"
}

# ALIASES
alias history='history 0'
alias k='kubectl'
alias ll='ls -la'
alias telnet='nc -vz'
alias net='ifconfig | grep inet'
alias pnet='curl ipecho.net/plain ; echo'
alias python=/usr/bin/python3
alias k8='ssh -i /Users/rh/.ssh/server ubuntu@54.86.25.52'

# PLUGINS
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# COMPLETION
autoload -U compinit; compinit

# KUBERNETES
#source <(kubectl completion zsh)

# PROMPT
eval "$(starship init zsh)"
export PATH="/usr/local/sbin:$PATH"
