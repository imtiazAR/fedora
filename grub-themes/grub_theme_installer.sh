#!/usr/bin/env bash

set -euo pipefail

THEME="Solara-left"
URL="https://raw.githubusercontent.com/imtiazAR/fedora/main/grub-themes/${THEME}.zip"

TMP_DIR="$(mktemp -d)"
THEME_DIR="/boot/grub2/themes"
GRUB_FILE="/etc/default/grub"

# Use sudo only when necessary
if (( EUID == 0 )); then
    SUDO=""
else
    SUDO="sudo"
fi

cleanup() {
    rm -rf "$TMP_DIR"
}

trap cleanup EXIT

error() {
    echo "Error: $*" >&2
    exit 1
}

echo "==> Checking requirements..."

command -v curl >/dev/null || error "curl is not installed."
command -v unzip >/dev/null || error "unzip is not installed."
command -v grub2-mkconfig >/dev/null || error "grub2-mkconfig is not installed."

# Ask for sudo password once
$SUDO -v

echo "==> Downloading ${THEME}..."

curl -fL --retry 3 "$URL" -o "$TMP_DIR/theme.zip"

echo "==> Extracting theme..."

$SUDO mkdir -p "$THEME_DIR"

# Remove previous version to avoid stale files
$SUDO rm -rf "${THEME_DIR}/${THEME}"

$SUDO unzip -oq "$TMP_DIR/theme.zip" -d "$THEME_DIR"

# Verify theme
[[ -f "${THEME_DIR}/${THEME}/theme.txt" ]] || \
    error "theme.txt was not found after extraction."

echo "==> Backing up GRUB configuration..."

$SUDO cp -an "$GRUB_FILE" "${GRUB_FILE}.bak"

update_var() {
    local key="$1"
    local value="$2"

    if grep -Eq "^[[:space:]]*${key}=" "$GRUB_FILE"; then
        $SUDO sed -Ei "s|^[[:space:]]*${key}=.*|${key}=${value}|" "$GRUB_FILE"
    else
        echo "${key}=${value}" | $SUDO tee -a "$GRUB_FILE" >/dev/null
    fi
}

echo "==> Configuring GRUB..."

update_var GRUB_TERMINAL_OUTPUT '"gfxterm"'
update_var GRUB_GFXMODE '"auto"'
update_var GRUB_GFXPAYLOAD_LINUX '"keep"'
update_var GRUB_THEME "\"${THEME_DIR}/${THEME}/theme.txt\""

echo "==> Regenerating grub.cfg..."

$SUDO grub2-mkconfig -o "$($SUDO readlink -f /etc/grub2.cfg)"

echo
echo "========================================="
echo " Theme installed successfully!"
echo " Theme : ${THEME}"
echo " Backup: ${GRUB_FILE}.bak"
echo "========================================="
echo
echo "Reboot your computer to see the new GRUB theme."
