function nextdns
    echo "Testing NextDNS connectivity..."
    echo
    
    # Test basic connectivity to test.nextdns.io
    echo "1. Testing test.nextdns.io connectivity:"
    if curl -s --connect-timeout 5 https://test.nextdns.io >/dev/null 2>&1
        echo "✓ HTTPS connection successful"
        # Get the actual test result
        set result (curl -s --connect-timeout 5 https://test.nextdns.io)
        echo "Response: $result"
    else
        echo "✗ HTTPS connection failed"
    end
    
    echo
    echo "2. Testing your NextDNS anycast IPs:"
    
    # Test DNS resolution through your NextDNS IPs
    set nextdns_ips 45.90.28.56 45.90.30.56
    
    for ip in $nextdns_ips
        echo "Testing DNS via $ip:"
        if dig @$ip google.com +short +timeout=3 >/dev/null 2>&1
            set response (dig @$ip google.com +short +timeout=3)
            echo "✓ DNS resolution working: $response"
        else
            echo "✗ DNS resolution failed"
        end
    end
    
    echo
    echo "3. Comparing with Cloudflare 1.1.1.1:"
    if dig @1.1.1.1 google.com +short +timeout=3 >/dev/null 2>&1
        set cf_response (dig @1.1.1.1 google.com +short +timeout=3)
        echo "✓ Cloudflare DNS working: $cf_response"
    else
        echo "✗ Cloudflare DNS failed"
    end
    
    echo
    echo "4. Testing NextDNS filtering (should block doubleclick.net):"
    for ip in $nextdns_ips
        echo "Testing filter via $ip:"
        set blocked_result (dig @$ip doubleclick.net +short +timeout=3 2>/dev/null)
        if test "$blocked_result" = "0.0.0.0"
            echo "✓ Filtering active (doubleclick.net blocked: $blocked_result)"
        else if test -z "$blocked_result"
            echo "✓ Filtering active (doubleclick.net blocked: no response)"
        else
            echo "✗ Filtering inactive: $blocked_result"
        end
    end
end