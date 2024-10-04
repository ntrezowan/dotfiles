# EXPORTS
export EDITOR="vim"
export VISUAL="vim"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# HISTORY
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

# ALIASES
alias history='history 0'
alias k='kubectl'
alias ll='ls -la'
alias telnet='nc -vz'
alias net='ifconfig | grep inet'
alias pnet='curl ipecho.net/plain ; echo'
alias python='/usr/bin/python3'

# PLUGINS
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# COMPLETION
autoload -U compinit; compinit

# FUNCTIONS
function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# KUBECTL
source <(kubectl completion zsh)

# PROMPT (Starship)
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
export PATH="/usr/local/sbin:$PATH"

# PROMPT (Pure)
#autoload -U promptinit; promptinit
#PURE_CMD_MAX_EXEC_TIME=10
#PURE_PROMPT_SYMBOL="$"
#PURE_PROMPT_SYMBOL='»'
#PURE_GIT_DOWN_ARROW='↓'
#PURE_GIT_UP_ARROW='↑'
#print() {
#  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
#}
#prompt pure
