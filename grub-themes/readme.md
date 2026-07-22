# Solara-left GRUB Theme for Fedora

A clean GRUB theme installer for Fedora.

## Features

* Automatic theme installation
* Automatic backup of `/etc/default/grub`
* Configures:

  * `GRUB_THEME`
  * `GRUB_TERMINAL_OUTPUT`
  * `GRUB_GFXMODE`
  * `GRUB_GFXPAYLOAD_LINUX`
* Regenerates `grub.cfg`
* No manual configuration required

## Requirements

* Fedora
* GRUB2
* `curl`
* `unzip`
* `sudo`

## Installation

Run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/main/grub-themes/grub_theme_installer.sh | bash
```

The installer will:

1. Download the Solara-left theme.
2. Install it to:

```text
/boot/grub2/themes/Solara-left
```

3. Update `/etc/default/grub`.
4. Regenerate the GRUB configuration.
5. Keep a backup of the original configuration as:

```text
/etc/default/grub.bak
```

## Applied GRUB Settings

```bash
GRUB_TERMINAL_OUTPUT="gfxterm"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_THEME="/boot/grub2/themes/Solara-left/theme.txt"
```

## Reboot

After installation, reboot your system:

```bash
systemctl reboot
```

## Uninstall

Remove the theme directory:

```bash
sudo rm -rf /boot/grub2/themes/Solara-left
```

Remove the following lines from `/etc/default/grub`:

```bash
GRUB_TERMINAL_OUTPUT="gfxterm"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_THEME="/boot/grub2/themes/Solara-left/theme.txt"
```

Regenerate the GRUB configuration:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

Or restore your backup:

```bash
sudo cp /etc/default/grub.bak /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

## License

This project is provided as-is. Use it at your own risk.

