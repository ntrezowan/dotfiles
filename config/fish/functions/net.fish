function net --wraps='ifconfig | grep inet' --description 'alias net=ifconfig | grep inet'
  ifconfig | grep inet $argv
        
end
