#!/bin/bash

set -e

DOTFILES="$HOME/Dropbox/dotfiles"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Check Dropbox is synced
if [ ! -d "$DOTFILES" ]; then
    error "Dropbox dotfiles not found at $DOTFILES. Wait for Dropbox to sync."
fi

if [ ! -d "$DOTFILES/config" ]; then
    error "Config directory missing in $DOTFILES"
fi

echo ""
echo "Creating symlinks from Dropbox dotfiles..."
echo ""

# ~/.config directory symlinks
mkdir -p ~/.config

configs=(
    "aerospace"
    "alacritty"
    "fish"
    "ghostty"
    "git"
    "iterm2"
    "kitty"
    "rio"
    "tmux"
    "wezterm"
    "zed"
    "zellij"
)

for config in "${configs[@]}"; do
    # Check if source exists in Dropbox
    if [ ! -d "$DOTFILES/config/$config" ]; then
        warn "Skipping $config (not found in Dropbox)"
        continue
    fi
    
    # Remove existing non-symlink
    if [ -e ~/.config/$config ] && [ ! -L ~/.config/$config ]; then
        warn "Backing up existing ~/.config/$config to ~/.config/$config.backup"
        mv ~/.config/$config ~/.config/$config.backup
    fi
    
    ln -sf "$DOTFILES/config/$config" ~/.config/$config
    log "~/.config/$config"
done

echo ""

# Root dotfiles
if [ -f "$DOTFILES/.zprofile" ]; then
    if [ -e ~/.zprofile ] && [ ! -L ~/.zprofile ]; then
        warn "Backing up existing ~/.zprofile"
        mv ~/.zprofile ~/.zprofile.backup
    fi
    ln -sf "$DOTFILES/.zprofile" ~/.zprofile
    log "~/.zprofile"
fi

if [ -f "$DOTFILES/.zshrc" ]; then
    if [ -e ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
        warn "Backing up existing ~/.zshrc"
        mv ~/.zshrc ~/.zshrc.backup
    fi
    ln -sf "$DOTFILES/.zshrc" ~/.zshrc
    log "~/.zshrc"
fi

if [ -d "$DOTFILES/.vimrc" ]; then
    if [ -e ~/.vimrc ] && [ ! -L ~/.vimrc ]; then
        warn "Backing up existing ~/.vimrc"
        mv ~/.vimrc ~/.vimrc.backup
    fi
    ln -sf "$DOTFILES/.vimrc" ~/.vimrc
    log "~/.vimrc"
fi

echo ""

# SSH config
if [ -f "$DOTFILES/ssh/config" ]; then
    mkdir -p ~/.ssh
    if [ -e ~/.ssh/config ] && [ ! -L ~/.ssh/config ]; then
        warn "Backing up existing ~/.ssh/config"
        mv ~/.ssh/config ~/.ssh/config.backup
    fi
    ln -sf "$DOTFILES/ssh/config" ~/.ssh/config
    chmod 600 "$DOTFILES/ssh/config"
    log "~/.ssh/config"
fi

echo ""
echo "Symlinks created successfully"
echo ""