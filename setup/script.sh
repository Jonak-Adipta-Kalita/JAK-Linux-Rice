#!/usr/bin/env bash

REPO_URL="https://github.com/Jonak-Adipta-Kalita/JAK-Linux-Rice.git"

set -euo pipefail

# --- Colors ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# --- Messages ---
info() { echo -e "${BLUE}[BOOTSTRAP]${NC} $1"; }
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
info "move to a directory where you want the whole repo to be cloned to..."
info "example: '/home/user/.jak-rice'; it is currently set to '$(pwd)'"
echo
read -p "clone it here? (y/N): " proceed

echo
if ! [[ "$proceed" == "y" || "$proceed" == "Y" ]]; then
	warn "change the directory :("
	exit 1
fi

REPO_DIR=$(pwd)
info "cloning repo into $REPO_DIR ... muehehe :D"

git clone --depth=1 -c advice.detachedHead=false $REPO_URL "$REPO_DIR"
