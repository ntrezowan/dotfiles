function pomodoro
    function usage
        echo "Usage: pomodoro [focus time] [short break] [long break]"
    end
    if test (count $argv) -gt 0
        if test "$argv[1]" = "-h"
            usage
            return 0
        end
    end
    
    # Set defaults first
    set -l focus_time 25
    set -l short_break 5  
    set -l long_break 15
    
    # Override with arguments if provided and valid
    if test -n "$argv[1]"; and string match -qr '^[0-9]+$' -- "$argv[1]"
        set focus_time $argv[1]
    end
    if test -n "$argv[2]"; and string match -qr '^[0-9]+$' -- "$argv[2]"
        set short_break $argv[2]
    end
    if test -n "$argv[3]"; and string match -qr '^[0-9]+$' -- "$argv[3]"
        set long_break $argv[3]
    end
    
    function notify
        set -l message $argv[1]
        set -l session_type $argv[2]
        # Gruvbox Material colors
        if test "$session_type" = "F"
            set -l bg_color '\e[48;2;142;192;124m'
            set -l fg_color '\e[38;2;40;40;40m'
        else
            set -l bg_color '\e[48;2;254;128;25m'
            set -l fg_color '\e[38;2;40;40;40m'
        end
        # Terminal flash
        printf '\e[?5h'
        sleep 0.2
        printf '\e[?5l'
        # System notification
        if type -q terminal-notifier
            terminal-notifier -title 'Pomodoro' -message "$message"
        else if type -q notify-send
            notify-send "$message"
        end
        # Terminal bell
        printf '\a'
    end

    function countdown
        set -l label $argv[2]
        set -l minutes $argv[1]
        set -l timer (math --scale=0 "$minutes * 60")
        while true
            set -l m (math --scale=0 "$timer / 60")
            set -l s (math --scale=0 "$timer % 60")
            # Change " - " to ": " for desired label format
            printf '\e[0K\r%s: %02d:%02d' $label $m $s
            if test $timer -eq 0
                break
            end
            set timer (math --scale=0 "$timer - 1")
            sleep 1
        end
        printf '\n'
    end

    # F1 - Focus session 1
    notify "F1" "F"
    countdown $focus_time "F1"
    
    # P1 - Pause/Break 1
    notify "P1" "P"
    countdown $short_break "P1"
    echo  # blank line between P1 and F2
    
    # F2 - Focus session 2
    notify "F2" "F"
    countdown $focus_time "F2"
    
    # P2 - Pause/Break 2
    notify "P2" "P"
    countdown $short_break "P2"
    echo  # blank line between P2 and F3
    
    # F3 - Focus session 3
    notify "F3" "F"
    countdown $focus_time "F3"
    
    # P3 - Pause/Break 3 (long break)
    notify "P3" "P"
    countdown $long_break "P3"
    
    echo "Take a break"
end