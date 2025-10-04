au
# -DRAFT-

1. Minimize Dock animation delay

    ```shell
    defaults write com.apple.dock autohide-time-modifier -float 0.1; killall Dock
    ```

1. Move windows by dragging any part of the window

    ```shell
    defaults write -g NSWindowShouldDragOnGesture -bool true
    ```

3. Disable windows opening animations

    ```shell
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
    ```

3. MacOS by default has a setting of `hibernatemode=3` but this setting keeps providing power to attached USB device when it sleeps

    ```shell
    sudo pmset -a hibernatemode 25
    ```

4. Disable bold font rendering in Alacritty

    ```shell
    defaults write org.alacritty AppleFontSmoothing -int 0
    ```

5. Disable bold font rendering in Weztern

    ```shell
    defaults write org.wezterm AppleFontSmoothing -int 0
    ```

---

# -Install packages-

1. Install Homebrew

    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    
3. Clone the repo

    ```shell
    git clone https://github.com/ntrezowan/dotfiles.git
    cd dotfiles
    ```
    
2. Install Bundle

    ```shell
    brew bundle install
    ```
    
4. Remove packages not installed from Brewfile

    ```shell
    brew bundle --force cleanup
    ```

---
