function brewup --wraps='brew update; brew upgrade; brew cleanup; brew doctor' --description 'alias brewup=brew update; brew upgrade; brew cleanup; brew doctor'
  brew update; brew upgrade; brew cleanup; brew doctor $argv
        
end
