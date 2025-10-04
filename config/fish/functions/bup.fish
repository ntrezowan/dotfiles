function bup
    echo "Updating brew..."
    brew update
    echo "Upgrading packages..."
    brew upgrade
    echo "Cleaning up..."
    brew cleanup
    echo "Running doctor..."
    brew doctor
end
