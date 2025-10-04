# Environment
set -gx EDITOR vim
set -gx PAGER less
set -gx LESS '-R'
set -g fish_term24bit 1

# Paths
source ~/.config/fish/functions/paths.fish

# History
set -g fish_history_ignore_duplicates true
set -g fish_history_ignore_leading_space true
set -g fish_history_time_format "%Y-%m-%d %H:%M:%S"
set -g fish_history_max 10000
set -gx HISTFILE_SIZE 50000
set -gx HISTSIZE 50000

# Interactive session
if status is-interactive
    source ~/.config/fish/functions/theme.fish
    # source ~/.config/fish/functions/kubectl_completion.fish
    if type -q fzf
    end
end