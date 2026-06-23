#!/usr/bin/env bash

REPO_URL="https://github.com/Jonak-Adipta-Kalita/JAK-Linux-Rice.git"

set -euo pipefail

# --- Helpers ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

if ! command -v pacman &> /dev/null; then
	error "not arch? wtf ya doin???"
	exit 1
fi

# --- Initialization ---
info "starting installer script... ehehehe :D"

echo
read -p "proceed? (y/N): " proceed
echo
if ! [[ "$proceed" == "y" || "$proceed" == "Y" ]]; then
	warn "i hope you change your min ><"
	exit 1
fi

INSTALL_DIR="$HOME/.local/share/jak-rice"
info "installing the files at $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
info "cloning repo into $INSTALL_DIR ... muehehe :D"
git clone --depth=1 -c advice.detachedHead=false $REPO_URL "$INSTALL_DIR"
cd "$INSTALL_DIR"
echo

# --- Installation ---
info "installing base packages"
sudo pacman -S --needed --noconfirm hyprland kitty git make curl jq
echo

info "installing rust via rustup..."
if command -v cargo &>/dev/null; then
    success "rust already installed"
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    source "$HOME/.cargo/env"

    rustup default stable

    success "rustup installed (stable toolchain set)"
fi

info "installing paru (AUR helper)..."
if command -v paru &> /dev/null; then
    success "paru already installed"
else
    tmp_dir="$(mktemp -d)"
    info "cloning paru into $tmp_dir"

    git clone https://aur.archlinux.org/paru.git "$tmp_dir/paru"
    cd "$tmp_dir/paru"

    makepkg -si --noconfirm

    cd "$REPO_DIR"
    rm -rf "$tmp_dir"

    success "paru installed successfully"
fi

info "installing clang + llvm toolchain..."
sudo pacman -S --needed --noconfirm clang llvm lld lldb

info "configuring audio system with pipewire"
sudo pacman -S --needed --noconfirm \
    pipewire \
    wireplumber \
    pipewire-alsa \
    pipewire-pulse \
    alsa-utils
cargo install wiremix

info "setting up fonts! fira-code for tui and ubuntu for ui"
sudo pacman -S --needed \
    ttf-fira-code \
    ttf-firacode-nerd \
    ttf-ubuntu-font-family \
    noto-fonts \
    noto-fonts-emoji

info "installing more packages (feel the bloat eh?)"
sudo pacman -S --needed --noconfirm \
	eza \
	neovim \
	fastfetch \
	tmux \
	yazi

# ... more installation ... ;-;

# --- Configuring & Ricing ---
for dir in "$REPO_DIR"/dotfiles/.config/*; do
    name=$(basename "$dir")

    echo "Linking $name"
    ln -sfn "$dir" "$HOME/.config/$name"
done
if [ -e "$HOME/.config/$name" ] && [ ! -L "$HOME/.config/$name" ]; then
    mv "$HOME/.config/$name" "$backup_dir/"
fi
for dir in "$REPO_DIR"/dotfiles/.config/*; do
    name=$(basename "$dir")

    echo "Linking $name"
    ln -sfn "$dir" "$HOME/.config/$name"
done
