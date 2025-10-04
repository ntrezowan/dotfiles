function telnet --wraps='nc -vz' --description 'alias telnet=nc -vz'
  nc -vz $argv
        
end
