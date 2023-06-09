This Brewfile installs all the necessary packages (according to me) required after getting a freshly installed MacOS.

### How to install packages

1. Install Homebrew
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Clone the repo
    ```
    git clone https://github.com/ntrezowan/device-config.git
    cd device-config
    ```
2. Install Bundle
    ```bash
    brew bundle install
    ```
3. Remove packages not installed from Brewfile
    ```
    brew bundle --force cleanup
    ```

---

### How to enable automatic package update
```
brew tap homebrew/autoupdate
```
