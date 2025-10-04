function man
    set -lx GROFF_NO_SGR 1
    set -lx LESS_TERMCAP_mb (set_color red)
    set -lx LESS_TERMCAP_md (set_color blue)
    set -lx LESS_TERMCAP_me (set_color normal)
    set -lx LESS_TERMCAP_se (set_color normal)
    set -lx LESS_TERMCAP_so (set_color -r black)
    set -lx LESS_TERMCAP_ue (set_color normal)
    set -lx LESS_TERMCAP_us (set_color magenta)
    command man $argv
end
