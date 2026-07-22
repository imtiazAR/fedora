#!/usr/bin/env bash

set -euo pipefail

APP_NAME="Signal"

APP_DIR="$HOME/Applications"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_DIR="$HOME/.local/share/applications"
TMP_DIR="$(mktemp -d)"

APPIMAGE="$APP_DIR/Signal.AppImage"
ICON="$ICON_DIR/signal.svg"
DESKTOP_FILE="$DESKTOP_DIR/signal.desktop"

APPIMAGE_URL="https://updates.signal.org/desktop/signal-desktop.AppImage"
SIGNATURE_URL="https://updates.signal.org/desktop/signal-desktop.AppImage.gpg"
PUBLIC_KEY_URL="https://updates.signal.org/static/desktop/appimage.asc"
ICON_URL="https://raw.githubusercontent.com/signalapp/Signal-Desktop/main/images/signal-heart.svg"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "==> Creating directories..."

mkdir -p \
    "$APP_DIR" \
    "$ICON_DIR" \
    "$DESKTOP_DIR"

cd "$TMP_DIR"

echo
echo "==> Downloading Signal AppImage..."
curl -fL "$APPIMAGE_URL" -o signal-desktop.AppImage

echo
echo "==> Downloading GPG Signature..."
curl -fL "$SIGNATURE_URL" -o signal-desktop.AppImage.gpg

echo
echo "==> Downloading Signal Public Key..."
curl -fL "$PUBLIC_KEY_URL" -o signal-appimage.asc

echo
echo "==> Importing Public Key..."
if ! gpg --list-keys 4B16B7232DFAA439AD791002EF9F501F13EED94C >/dev/null 2>&1; then
    gpg --import signal-appimage.asc
fi

echo
echo "==> Verifying AppImage..."

gpg --verify \
    signal-desktop.AppImage.gpg \
    signal-desktop.AppImage

echo
echo "==> Installing AppImage..."

install -Dm755 \
    signal-desktop.AppImage \
    "$APPIMAGE"

echo
echo "==> Downloading Official Icon..."

curl -fL \
    "$ICON_URL" \
    -o "$ICON"

echo
echo "==> Creating Desktop Entry..."

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Signal
GenericName=Private Messenger
Comment=Fast, simple, and secure messaging
Exec=$APPIMAGE
Icon=$ICON
Terminal=false
Categories=Network;InstantMessaging;
Keywords=signal;chat;messenger;
StartupNotify=true
StartupWMClass=Signal
EOF

chmod +x "$DESKTOP_FILE"

if command -v update-desktop-database >/dev/null 2>&1; then
    echo "==> Updating desktop database..."
    update-desktop-database "$DESKTOP_DIR" >/dev/null
fi

echo
echo "=============================================="
echo " $APP_NAME has been installed successfully."
echo " Launch it from the GNOME application menu."
echo "=============================================="
echo "Installed:"
echo "$APPIMAGE"
