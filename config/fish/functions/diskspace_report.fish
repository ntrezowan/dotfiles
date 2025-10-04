function diskspace_report --wraps='df --si /' --description 'alias diskspace_report=df --si /'
  df --si / $argv
        
end
