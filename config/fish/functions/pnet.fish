function pnet --wraps='echo -e "IP = (curl -s ipinfo.io/ip)\\nCity = (curl -s ipinfo.io/city)"' --description 'alias pnet=echo -e "IP = (curl -s ipinfo.io/ip)\\nCity = (curl -s ipinfo.io/city)"'
  echo -e "IP = (curl -s ipinfo.io/ip)\nCity = (curl -s ipinfo.io/city)" $argv
        
end
