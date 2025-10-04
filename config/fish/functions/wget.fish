function wget --wraps='curl -L -O' --description 'alias wget=curl -L -O'
  curl -L -O $argv
        
end
