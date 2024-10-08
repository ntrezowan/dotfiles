This Brewfile installs all the necessary packages (according to me) required after getting a freshly installed MacOS.

---

### How to install packages

1. Install Homebrew
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Clone the repo
    ```
    git clone https://github.com/ntrezowan/workstation-config.git
    cd workstation-config
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

1. Enable Brew auto update
    ```
    brew tap homebrew/autoupdate
    ```

2. Check status
    ```
    brew autoupdate status
    ```


# Custom configurations

1. MacOS by default has a setting of `hibernatemode=3` but this setting keeps providing power to attached USB device when it sleeps. To avoid this -

```shell
sudo pmset -a hibernatemode 25
```
