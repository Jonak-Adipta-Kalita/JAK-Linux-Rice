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

# --- Installation ---
info "starting installer script... ehehehe :D"

echo
read -p "info proceed? (y/N): " proceed
echo
if ! [[ "$proceed" == "y" || "$proceed" == "Y" ]]; then
	warn "i hope you change your mind ><"
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
echo

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
echo

info "installing clang + llvm toolchain..."
sudo pacman -S --needed --noconfirm clang llvm lld lldb
echo

info "configuring audio system with pipewire"
sudo pacman -S --needed --noconfirm \
    pipewire \
    wireplumber \
    pipewire-alsa \
    pipewire-pulse \
    alsa-utils \
	ffmpeg
cargo install wiremix
echo

info "setting up fonts! jetbrains-mono for tui and noto-fonts for ui"
sudo pacman -S --needed --noconfirm \
	ttf-jetbrains-mono-nerd \
	ttf-nerd-fonts-symbols \
	noto-fonts \
	noto-fonts-emoji \
	noto-fonts-cjk
echo

# --- Configuring & Ricing ---
info "the main ricing config part... installing more packages (feel the bloat eh?)"
sudo pacman -S --needed --noconfirm \
	fish \
	eza \
	neovim \
	fastfetch \
	tmux \
	yazi \
	btop \
	unzip \
	less \
	waybar \
	swaync \
	rofi-wayland \
	nwg-look
paru -S --needed --noconfirm \
	awww \
	tree
echo

info "getting the lovely wallpapers"
xdg-users-dirs-update
ln -sfn "$REPO_DIR"/assets/wallpapers "$HOME/Pictures/Wallpapers"
awww-daemon & disown
awww img "$REPO_DIR"/assets/wallpapers/arch.png
echo

if [ -e "$HOME/.config/$name" ] && [ ! -L "$HOME/.config/$name" ]; then
    mv "$HOME/.config/$name" "$backup_dir/"
fi
for dir in "$REPO_DIR"/dotfiles/.config/*; do
    name=$(basename "$dir")

    info "Linking $name"
    ln -sfn "$dir" "$HOME/.config/$name"
done
ln -sfn "$REPO_DIR"/.bashrc $HOME/.bashrc
echo

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sfn "$REPO_DIR"/dotfiles/.tmux.conf $HOME/.config/.tmux.conf
echo

ln -sfn "$REPO_DIR"/dotfiles/.gtkrc-2.0 $HOME/.config/.gtkrc-2.0
echo

git config --global init.defaultBranch main
echo

# --- Installation ---
info "installing fish shell..."
command -v fish | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
fish
curl -sS https://starship.rs/install.sh | sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher
fisher install catppuccin/fish

info "getting the desktop applications... :D"
paru -S --needed --noconfirm \
  vesktop \
  spotify \
  spicetify-cli
sudo pacman -S --needed --noconfirm \
  flatpak \
  obsidian
flatpak install flathub app.zen_browser.zen
echo

info "real quick... go open spotify and login, and stay there for like a min... need some gen files"
read -p "info done?" spotify_done
sudo chmod a+wr /opt/spotify
sudo chmod -R a+wr /opt/spotify/Apps
spicetify apply
echo

info "installing node & web stuff eheheh"
fisher install jorgebucaran/nvm.fish
nvm install lts
nvm use lts
corepack enable
yes | yarn -v
paru -S --needed --noconfirm ngrok

info "installing game-dev env with c#"
sudo pacman -S --needed --noconfirm \
  dotnet-sdk \
  gimp \
  godot-mono \
  blender
echo

info "setting up printer stuff"
sudo pacman -S --needed --noconfirm \
	cups \
	cups-filters \
	system-config-printer
sudo systemctl enable --now cups
sudo groupadd lpadmin 2>/dev/null
sudo usermod -aG lpadmin $USER
info "setup printer using lpinfo and lpadmin :D"
read -p "info ok?" printer_understood
echo

info "setting up music prod stuff"
sudo pacman -S --needed --noconfirm \
  audacity \
  reaper \
  ffmpeg \
  qpwgraph
