function fish_prompt
    set_color '#b8bb26'
    echo -n (basename (prompt_pwd))
    set_color yellow
    echo -n " $ "
    set_color normal
end
