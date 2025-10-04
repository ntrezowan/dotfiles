function hist
    history --show-time | awk '
    /^# / {
        month_map["Jan"]="01"; month_map["Feb"]="02"; month_map["Mar"]="03"; month_map["Apr"]="04"
        month_map["May"]="05"; month_map["Jun"]="06"; month_map["Jul"]="07"; month_map["Aug"]="08"
        month_map["Sep"]="09"; month_map["Oct"]="10"; month_map["Nov"]="11"; month_map["Dec"]="12"

        split($5, time_parts, ":")
        timestamp = sprintf("%s-%s-%02d %s.%s.%s", $6, month_map[$3], $4, time_parts[1], time_parts[2], time_parts[3])
        next
    }
    /^[^#]/ {
        print timestamp " -> " $0
    }' | tail -r
end
