## Quick Start

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/main/apps/signal_installer.sh)
```

# Fedora

Personal Fedora setup scripts and installers.

This repository contains simple Bash scripts to automate common tasks after installing Fedora. Each script is independent and can be executed directly from GitHub using `curl`.

> **Warning**
>
> Always review a script before executing it with `curl | bash` or `bash <(...)`.

---

## Available Scripts

| Script | Description | Run |
|---------|-------------|-----|
| Signal Installer | Install the latest Signal AppImage with GPG verification | `bash <(curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/main/apps/signal_installer.sh)` |

---

## Usage

Run any script directly without cloning the repository.

Example:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/imtiazAR/fedora/main/apps/signal_installer.sh)
```

---

## Repository Structure

```text
fedora/
├── apps/
│   ├── signal_installer.sh
│   ├── vscode_installer.sh
│   └── ...
├── system/
│   ├── update.sh
│   ├── rpmfusion.sh
│   ├── codecs.sh
│   └── full_setup.sh
├── dotfiles/
│   └── bashrc
└── README.md
```

---

## Requirements

- Fedora Linux
- Bash
- curl

---

