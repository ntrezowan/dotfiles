1. Install Dropbox, sign in
2. Run setup

      `bash ~/Dropbox/dotfiles/scripts/setup.sh`

3. Restart


~/Dropbox/dotfiles/
├── Brewfile                      # Your merged Brewfile
├── config/                       # Your symlinked configs
│   ├── fish/
│   ├── git/
│   └── ...
├── scripts/
│   ├── setup.sh                  # Main setup script (above)
│   ├── symlinks.sh              # Your symlink script
│   └── macos-defaults.sh        # Your defaults script
├── ssh/
│   └── config                    # SSH config (not keys!)
├── .zshrc
├── .zprofile
└── .vimrc
