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

# Git & SSH Setup

A simple Fedora script for setting up Git and an Ed25519 SSH key.

The script automatically:

* Installs Git if it is not installed
* Installs Micro if it is not installed
* Configures Git username and email
* Uses a 5-second timeout for Git configuration prompts
* Sets `main` as the default Git branch
* Sets Micro as the Git editor
* Configures Git merge conflict style
* Configures Git pull behavior
* Adds useful Git aliases
* Generates an Ed25519 SSH key if one does not already exist
* Preserves an existing SSH key
* Sets SSH key permissions
* Displays the SSH public key
* Shows GitHub and GitLab SSH test commands

`gh` GitHub CLI is **not required**.

---

## Quick Start

Run the script directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/refs/heads/main/setup/git_setup | bash
```

The script is designed to run directly with `curl | bash`.

---

## What the Script Does

### 1. Git

The script checks whether Git is installed.

If Git is missing, it automatically installs it using Fedora's DNF:

```bash
sudo dnf install -y git
```

If Git is already installed, no installation is performed.

---

### 2. Micro

The script checks whether Micro is installed.

If Micro is missing, it automatically installs it:

```bash
sudo dnf install -y micro
```

Micro is configured as the Git editor.

---

## Git Configuration

The default Git identity is:

```text
Name : ImtiazAR
Email: 169064290+imtiazAR@users.noreply.github.com
```

The script asks for:

```text
Git username
Git email
```

Each prompt has a **5-second timeout**.

Press Enter to keep the default value. If there is no input within 5 seconds, the default value is automatically used.

The following Git settings are configured:

```bash
git config --global user.name
git config --global user.email
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global merge.conflictstyle zdiff3
git config --global core.editor micro
git config --global pull.rebase false
```

---

## Git Aliases

The script configures the following aliases:

| Alias              | Command                   |
| ------------------ | ------------------------- |
| `git st`           | `git status`              |
| `git br`           | `git branch`              |
| `git co`           | `git checkout`            |
| `git cm "message"` | `git commit -m "message"` |
| `git lg`           | Graphical one-line log    |

### Examples

```bash
git st
```

```bash
git br
```

```bash
git co main
```

```bash
git cm "Initial commit"
```

```bash
git lg
```

The `git lg` alias expands to:

```bash
git log --graph --oneline --decorate --all
```

---

## SSH Key

The script uses an Ed25519 SSH key:

```text
~/.ssh/id_ed25519
```

### If the key does not exist

A new key is generated with:

```bash
ssh-keygen -t ed25519
```

The configured Git email is used as the SSH key comment.

### If the key already exists

The existing key is preserved.

The script does **not** overwrite the existing `~/.ssh/id_ed25519`.

---

## SSH Permissions

The script ensures the following permissions:

```text
~/.ssh             700
~/.ssh/id_ed25519 600
~/.ssh/id_ed25519.pub 644
```

---

## Add the SSH Key to GitHub

After generating or finding the SSH key, the script displays the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the complete public key and add it to your GitHub account:

```text
Settings
→ SSH and GPG keys
→ New SSH key
```

Then test the connection:

```bash
ssh -T git@github.com
```

---

## Add the SSH Key to GitLab

The same SSH public key can also be added to GitLab.

Go to:

```text
Preferences
→ SSH Keys
→ Add new key
```

Then test the connection:

```bash
ssh -T git@gitlab.com
```

---

## Clone Repositories Using SSH

### GitHub

```bash
git clone git@github.com:USERNAME/REPOSITORY.git
```

### GitLab

```bash
git clone git@gitlab.com:USERNAME/REPOSITORY.git
```

After SSH authentication is configured, normal Git operations work through SSH:

```bash
git pull
git push
git fetch
```

No GitHub CLI authentication is required.

---

## Verify Git Configuration

Check the configured Git identity:

```bash
git config --global user.name
git config --global user.email
```

Check all global Git configuration:

```bash
git config --global --list
```

---

## Verify the SSH Key

List the SSH key files:

```bash
ls -la ~/.ssh/id_ed25519*
```

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## Requirements

* Fedora Linux
* Internet connection
* `sudo` access when running as a normal user

The script uses Fedora's `dnf` package manager.

---

## Notes

* `gh` GitHub CLI is not required.
* The script does not automatically upload the SSH key to GitHub or GitLab.
* The SSH public key must be added manually to the desired Git hosting account.
* Existing `~/.ssh/id_ed25519` keys are preserved.
* The script configures the global Git settings.
* The script is intended for Fedora systems.
* The script does not start or configure an `ssh-agent`.

---

## License

Use, modify, and distribute as you like.

