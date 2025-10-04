function proton
    echo "Testing ProtonVPN connectivity..."
    echo
    
    # Initialize variables
    set current_ip ""
    set location_info ""
    set dns_status ""
    set ipv6_status ""
    set vpn_detection ""
    set timezone_status ""
    set cross_verify_status ""
    
    # Test 1: Get current public IP and location
    set current_ip (curl -s --connect-timeout 10 https://ipinfo.io/ip 2>/dev/null)
    if test -n "$current_ip"
        set location_info (curl -s --connect-timeout 10 "https://ipinfo.io/$current_ip" 2>/dev/null | jq -r '.city + ", " + .region + ", " + .country')
        set ip_status "✓"
    else
        set ip_status "✗"
        set current_ip "Failed to detect"
        set location_info "Unknown"
    end
    
    # Test 2: Check for DNS leaks
    set dns_servers (dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null)
    if test -n "$dns_servers"
        if test "$dns_servers" != "$current_ip"
            set dns_status "⚠"
            set dns_info "Potential leak: $dns_servers"
        else
            set dns_status "✓"
            set dns_info "No leak detected: $dns_servers"
        end
    else
        set dns_status "✗"
        set dns_info "DNS leak test failed"
    end
    
    # Test 3: Check for IPv6 leaks
    set ipv6_ip (curl -s --connect-timeout 5 https://ipv6.icanhazip.com 2>/dev/null)
    if test -n "$ipv6_ip"
        set ipv6_status "⚠"
        set ipv6_info "IPv6 leak detected: $ipv6_ip"
    else
        set ipv6_status "✓"
        set ipv6_info "No IPv6 detected"
    end
    
    # Test 4: Cross-verification with multiple services
    set services "https://icanhazip.com" "https://ifconfig.me/ip" "https://checkip.amazonaws.com"
    set mismatch_count 0
    set working_services 0
    for service in $services
        set ip (curl -s --connect-timeout 3 $service 2>/dev/null | tr -d '\n\r')
        if test -n "$ip"
            set working_services (math $working_services + 1)
            if test "$ip" != "$current_ip"
                set mismatch_count (math $mismatch_count + 1)
            end
        end
    end
    
    if test $mismatch_count -gt 0
        set cross_verify_status "⚠"
        set cross_verify_info "$mismatch_count mismatches out of $working_services services"
    else if test $working_services -gt 0
        set cross_verify_status "✓"
        set cross_verify_info "All $working_services services consistent"
    else
        set cross_verify_status "✗"
        set cross_verify_info "All services failed"
    end
    
    # Test 5: Check for common VPN detection
    set vpn_check (curl -s --connect-timeout 5 "https://ipinfo.io/$current_ip" 2>/dev/null | jq -r '.org // "unknown"')
    if string match -q "*VPN*" "$vpn_check"; or string match -q "*Proton*" "$vpn_check"
        set vpn_detection "⚠"
        set vpn_info "VPN detected: $vpn_check"
    else if test "$vpn_check" != "unknown"
        set vpn_detection "✓"
        set vpn_info "Not detected as VPN: $vpn_check"
    else
        set vpn_detection "✗"
        set vpn_info "Could not check VPN detection"
    end
    
    # Test 6: Time zone leak check
    set system_tz (date +%Z)
    set web_tz (curl -s --connect-timeout 5 "http://worldtimeapi.org/api/ip" 2>/dev/null | jq -r '.timezone // "unknown"')
    if test "$web_tz" != "unknown"
        if test "$system_tz" != (echo "$web_tz" | cut -d'/' -f2)
            set timezone_status "✓"
            set timezone_info "Masked ($system_tz vs $web_tz)"
        else
            set timezone_status "⚠"
            set timezone_info "Potential leak ($system_tz matches $web_tz)"
        end
    else
        set timezone_status "✗"
        set timezone_info "Could not check timezone"
    end
    
    # Print table
    printf "┌──────────────────────────────┬────────┬─────────────────────────────────────────────────┐\n"
    printf "│ Test                         │ Status │ Information                                     │\n"
    printf "├──────────────────────────────┼────────┼─────────────────────────────────────────────────┤\n"
    printf "│ %-28s │   %s    │ %-47s │\n" "Current IP" "$ip_status" "$current_ip"
    printf "│ %-28s │   %s    │ %-47s │\n" "Location" "$ip_status" "$location_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "DNS Leak Test" "$dns_status" "$dns_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "IPv6 Leak Test" "$ipv6_status" "$ipv6_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "Cross Verification" "$cross_verify_status" "$cross_verify_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "VPN Detection" "$vpn_detection" "$vpn_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "Timezone Leak" "$timezone_status" "$timezone_info"
    printf "│ %-28s │   %s    │ %-47s │\n" "Torrent IP Check" "-" "Visit ipleak.net - match: $current_ip"
    printf "└──────────────────────────────┴────────┴─────────────────────────────────────────────────┘\n"
    
    echo
    echo "Legend: ✓ = Good | ⚠ = Warning | ✗ = Problem | - = Manual Check"
end