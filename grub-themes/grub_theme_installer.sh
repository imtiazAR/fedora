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
$SUDO rm -rf "${THEME_DIR}/${THEME}"

# Extract zip file
$SUDO unzip -oq "$TMP_DIR/theme.zip" -d "$THEME_DIR"

# Fix permissions so GRUB and user tools can read it
$SUDO chmod -R a+rX "${THEME_DIR}/${THEME}"

# Verify theme with sudo to prevent permission issues
if ! $SUDO test -f "${THEME_DIR}/${THEME}/theme.txt"; then
    FOUND_THEME=$($SUDO find "$THEME_DIR" -name "theme.txt" -print -quit 2>/dev/null)
    if [[ -z "$FOUND_THEME" ]]; then
        error "theme.txt was not found after extraction."
    fi
fi

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
