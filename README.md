This Brewfile installs all the necessary packages (according to me) required after getting a freshly installed MacOS.

1. Install Homebrew;
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
  
2. Install Bundle;
    ```bash
    brew bundle install
    ```
3. Remove packages not installed from `Brewfile`;
    ```
    brew bundle --force cleanup
    ```
