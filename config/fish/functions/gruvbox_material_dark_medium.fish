# ============================================================================= 
# Theme for Fish
# (goes to ~/.config/fish/functions//gruvbox-material-dark-medium.toml)
# ============================================================================= 

function gruvbox_material_dark_medium -d "Set Gruvbox Material Dark Medium colors"
    # Set terminal colors
    set -U fish_color_normal d4be98
    set -U fish_color_command a9b665
    set -U fish_color_keyword d3869b
    set -U fish_color_quote d8a657
    set -U fish_color_redirection 89b482
    set -U fish_color_end ea6962
    set -U fish_color_error ea6962
    set -U fish_color_param ddc7a1
    set -U fish_color_comment 928374
    set -U fish_color_selection --background=3c3836
    set -U fish_color_search_match --background=45403d
    set -U fish_color_operator 89b482
    set -U fish_color_escape e78a4e
    set -U fish_color_autosuggestion 7c6f64
    set -U fish_color_cancel ea6962

    # Set pager colors
    set -U fish_pager_color_progress 928374
    set -U fish_pager_color_background
    set -U fish_pager_color_prefix a9b665
    set -U fish_pager_color_completion d4be98
    set -U fish_pager_color_description 928374
    set -U fish_pager_color_selected_background --background=3c3836
    set -U fish_pager_color_selected_prefix a9b665
    set -U fish_pager_color_selected_completion d4be98
    set -U fish_pager_color_selected_description 928374
    set -U fish_pager_color_secondary_background
    set -U fish_pager_color_secondary_prefix 89b482
    set -U fish_pager_color_secondary_completion 7daea3
    set -U fish_pager_color_secondary_description 928374

    # Set prompt colors
    set -U fish_color_cwd a9b665
    set -U fish_color_cwd_root ea6962
    set -U fish_color_user 7daea3
    set -U fish_color_host d4be98
    set -U fish_color_host_remote d8a657
    set -U fish_color_status ea6962

    # Set git prompt colors
    set -U __fish_git_prompt_color_branch d8a657
    set -U __fish_git_prompt_color_branch_detached ea6962
    set -U __fish_git_prompt_color_upstream 89b482
    set -U __fish_git_prompt_color_upstream_ahead a9b665
    set -U __fish_git_prompt_color_upstream_behind ea6962
    set -U __fish_git_prompt_color_stash d3869b
    set -U __fish_git_prompt_color_dirtystate ea6962
    set -U __fish_git_prompt_color_stagedstate a9b665
    set -U __fish_git_prompt_color_invalidstate ea6962
    set -U __fish_git_prompt_color_untrackedfiles e78a4e
    set -U __fish_git_prompt_color_cleanstate a9b665

    echo "Gruvbox Material Dark Medium theme applied!"
    echo "Restart your shell or run 'exec fish' to see changes."
end