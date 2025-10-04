1. Install Dropbox, wait for sync

2. Install Homebrew

      `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

3. Create symlinks

      `bash ~/Dropbox/dotfiles/scripts/symlinks.sh`

4. Install apps

  ```
  brew bundle install --file=~/Dropbox/dotfiles/Brewfile
  ```

5. Apply macOS defaults

  ```
  bash ~/Dropbox/dotfiles/scripts/macos-defaults.sh
  ```

6. Restart
