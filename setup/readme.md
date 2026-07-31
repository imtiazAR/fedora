# Fedora Post Install Script

A simple Fedora post-install script for quickly setting up a fresh Fedora installation.

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

Run the script directly:

```bash
curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/refs/heads/main/setup/post_quick_setup | bash
```

Or download it first:

```bash
curl -O https://raw.githubusercontent.com/imtiazAR/fedora/refs/heads/main/setup/post_quick_setup
chmod +x post_quick_setup
./post_quick_setup
```

## What the script does

1. Configures DNF
2. Enables RPM Fusion repositories
3. Updates AppStream metadata
4. Installs multimedia codecs
5. Refreshes firmware metadata
6. Updates the system

## Requirements

* Fedora Workstation
* Internet connection
* `sudo` privileges

## Notes

* Safe to run multiple times.
* Existing `dnf.conf` settings are updated instead of replacing the file.
* Intended for fresh Fedora installations.

## License

MIT
