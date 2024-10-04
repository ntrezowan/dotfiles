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

# PROMPT
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
export PATH="/usr/local/sbin:$PATH"
