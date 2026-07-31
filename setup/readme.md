# Fedora Post Install Script

A simple Fedora post-install script for personal use.

It performs the essential setup after a fresh Fedora installation.

## Features

* Configure DNF

  * `max_parallel_downloads=10`
  * `fastestmirror=true`
  * `defaultyes=true`
  * `keepcache=true`
* Add a commented `excludepkgs` example
* Enable RPM Fusion (Free & Nonfree)
* Upgrade AppStream metadata
* Install multimedia codecs
* Replace `ffmpeg-free` with `ffmpeg`
* Refresh firmware metadata
* Check for firmware updates
* Perform a full system upgrade

## Usage

Run the script directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/main/fedora-post-install.sh | bash
```

Or download it first:

```bash
curl -O https://raw.githubusercontent.com/imtiazAR/fedora/main/fedora-post-install.sh
chmod +x fedora-post-install.sh
./fedora-post-install.sh
```

## What the script does

1. Configures DNF
2. Enables RPM Fusion repositories
3. Updates AppStream metadata
4. Installs multimedia codecs
5. Refreshes firmware metadata
6. Updates the entire system

## Requirements

* Fedora Workstation
* Internet connection
* `sudo` privileges

## Notes

* The script is idempotent and can be run multiple times.
* Existing DNF options are updated instead of replacing the entire `dnf.conf`.
* The script is intended for fresh Fedora installations.

