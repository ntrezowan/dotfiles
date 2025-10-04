#!/bin/bash
# Complete macOS Setup Script
# Run this on a fresh machine after Dropbox syncs

set -e

DOTFILES="$HOME/Dropbox/dotfiles"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Check macOS
[[ "$OSTYPE" != "darwin"* ]] && error "This script is for macOS only"

# Check Dropbox is synced
if [ ! -d "$DOTFILES" ]; then
    error "Dropbox dotfiles not found at $DOTFILES. Wait for Dropbox to sync."
fi

echo ""
log "Starting macOS Setup..."
echo ""

# 1. Xcode Command Line Tools
log "Checking Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    warn "Installing Xcode Command Line Tools..."
    xcode-select --install
    warn "Complete Xcode installation and re-run this script"
    exit 0
else
    log "Xcode Command Line Tools already installed"
fi

echo ""

# 2. Install Homebrew
if ! command -v brew &> /dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH (handles M1/M2 vs Intel)
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    else
        eval "$(/usr/local/bin/brew shellenv)"
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
    fi
    log "Homebrew installed"
else
    log "Homebrew already installed"
fi

echo ""

# 3. Create symlinks
log "Creating dotfile symlinks..."
bash "$DOTFILES/scripts/symlinks.sh"

echo ""

# 4. Install from Brewfile
log "Installing apps from Brewfile..."
brew update
brew bundle install --file="$DOTFILES/Brewfile" --verbose
brew cleanup
log "Homebrew packages installed"

echo ""

# 5. Configure macOS defaults
if [ -f "$DOTFILES/scripts/macos-defaults.sh" ]; then
    log "Configuring macOS system preferences..."
    bash "$DOTFILES/scripts/macos-defaults.sh"
else
    warn "macos-defaults.sh not found, skipping"
fi

echo ""

# 6. Set Fish as default shell
if command -v fish &> /dev/null; then
    log "Setting Fish as default shell..."
    FISH_PATH=$(which fish)
    
    if ! grep -q "$FISH_PATH" /etc/shells; then
        echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    
    if [[ "$SHELL" != "$FISH_PATH" ]]; then
        chsh -s "$FISH_PATH"
        log "Default shell set to Fish (restart terminal)"
    fi
else
    warn "Fish not installed, skipping shell change"
fi

echo ""

# 7. Create standard directories
log "Creating standard directories..."
mkdir -p ~/Development
mkdir -p ~/Documents/Scripts
mkdir -p ~/Projects

echo ""
echo "Setup complete!"
echo ""
echo "Manual steps remaining:"
echo "  1. Restart your terminal"
echo "  2. Sign into apps: Bitwarden, Obsidian, VS Code, Dropbox"
echo "  3. System Settings -> Privacy & Security -> Full Disk Access"
echo "     Add: Terminal, iTerm2, Alacritty, Ghostty"
echo "  4. Generate/restore SSH keys manually"
echo "  5. Configure Git: git config --global user.name 'Your Name'"
echo "                    git config --global user.email 'you@example.com'"
echo ""