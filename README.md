# Development Environment Setup Script

This repository contains scripts to automatically install essential software and tools for setting up a complete development environment on Linux.

## Folder Structure

* `Arch Based Distros/script.sh` – Use this if you are on Arch Linux, Manjaro, EndeavourOS, etc.
* `Debian or Ubuntu Based Distros/script.sh` – Use this if you are on Ubuntu, Linux Mint, Pop!\_OS, etc.

## Features

* System update and upgrade
* Core tools: `git`, `curl`, `wget`
* Web browser: `Firefox`
* `Wine` for running Windows apps
* `Zsh` and `Oh My Zsh` for an improved terminal
* `Powerlevel10k` Zsh theme
* `Neofetch` for system info display
* Compiler tools: `GCC`, `G++`, build tools
* Java: `OpenJDK 17`
* Code editor: `Visual Studio Code`
* Popular apps: `CopyQ`, `GNOME Boxes`, `VLC`, `GIMP`, `KDE Connect`
* `Flatpak` and `Bottles` support
* `GitHub CLI` for GitHub access
* `Ferdium` (messaging) via Snap (Debian) or AUR (Arch)

## Prerequisites

* A Linux distribution based on either **Debian** or **Arch**
* Internet connection
* `sudo` privileges

## How to Run

### Option 1: Clone the repository

1. Clone this repository:

   ```bash
   git clone https://github.com/Bharathsencha/Auto-Install-Linux-Essential-Apps.git
   cd Auto-Install-Linux-Essential-Apps
   ```

2. Navigate to the folder for your distro:

   ```bash
   cd "Debian or Ubuntu Based Distros"
   # or
   cd "Arch Based Distros"
   ```

3. Run the script:

   ```bash
   sh script.sh
   ```

   Or, if you prefer:

   ```bash
   chmod +x script.sh
   ./script.sh
   ```

### Option 2: Download the script file directly

1. Download the `script.sh` file for your distro from the GitHub repo.
2. Move to your Downloads folder:

   ```bash
   cd ~/Downloads
   ```
3. Run the script:

   ```bash
   sh script.sh
   ```

## Configuring Powerlevel10k

After installation, to configure your terminal prompt:

```bash
p10k configure
```

Follow the interactive setup to personalize your prompt.

## Customizing the Script

You can edit `script.sh` using any text editor to:

* Add or remove packages
* Adjust configurations to suit your needs
* Comment out software you don't want
* If Zsh or p10k dosen't work reboot your system before trying other methods 

For example:

```bash
nano script.sh
```

Then modify the list of apps or commands as needed.

---

Simple, fast, and easy way to get your dev setup ready!!
