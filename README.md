This Brewfile installs all the necessary packages (according to me) required after getting a freshly installed MacOS.

---

### How to install packages

1. Install Homebrew
    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Clone the repo
    ```shell
    git clone https://github.com/ntrezowan/workstation-config.git
    cd workstation-config
    ```
2. Install Bundle
    ```shell
    brew bundle install
    ```
3. Remove packages not installed from Brewfile
    ```shell
    brew bundle --force cleanup
    ```

---

### How to enable automatic package update

1. Enable Brew auto update
    ```shell
    brew tap homebrew/autoupdate
    ```

2. Check status
    ```shell
    brew autoupdate status
    ```


# Custom configurations

1. MacOS by default has a setting of `hibernatemode=3` but this setting keeps providing power to attached USB device when it sleeps. To avoid this -

    ```shell
    sudo pmset -a hibernatemode 25
    ```
