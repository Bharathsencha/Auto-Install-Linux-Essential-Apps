#!/bin/bash

# Exit if any command fails
set -e

echo "Updating system..."
sudo dnf update -y

echo "Installing core tools: git, curl, wget..."
sudo dnf install -y git curl wget

echo "Installing Firefox..."
sudo dnf install -y firefox

echo "Installing Wine (64-bit and 32-bit)..."
sudo dnf install -y wine

echo "Installing Zsh..."
sudo dnf install -y zsh
chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k theme
echo "Installing Powerlevel10k..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

echo "Installing Neofetch..."
sudo dnf install -y neofetch

echo "Installing GCC, G++, and build tools..."
sudo dnf groupinstall -y "Development Tools"

echo "Installing OpenJDK 17 (Java)..."
sudo dnf install -y java-17-openjdk-devel

echo "Installing Visual Studio Code..."
if ! command -v code &>/dev/null; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo "deb [arch=x86_64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/yum.repos.d/vscode.repo
  sudo dnf install -y code
fi

echo "Installing CopyQ..."
sudo dnf install -y copyq

echo "Installing GNOME Boxes..."
sudo dnf install -y gnome-boxes

echo "Installing Flatpak and Flathub..."
sudo dnf install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Bottles via Flatpak..."
flatpak install -y flathub com.usebottles.bottles

echo "Installing VLC media player..."
sudo dnf install -y vlc

echo "Installing GIMP..."
sudo dnf install -y gimp

echo "Installing KDE Connect..."
sudo dnf install -y kdeconnect

echo "Installing GitHub CLI..."
if ! command -v gh &>/dev/null; then
  sudo rpm --import https://cli.github.com/packages/githubcli-archive-keyring.gpg
  echo "deb [arch=$(uname -m) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/yum.repos.d/github-cli.repo
  sudo dnf install -y gh
fi

echo "Installing Ferdium (.rpm)..."
FERDIUM_URL=$(curl -s https://api.github.com/repos/ferdium/ferdium-app/releases/latest \
  | grep "browser_download_url.*\.rpm" \
  | cut -d '"' -f 4 | grep x86_64 | head -n 1)

if [ -n "$FERDIUM_URL" ]; then
  wget -O ferdium.rpm "$FERDIUM_URL"
  sudo dnf install -y ./ferdium.rpm
  rm ferdium.rpm
else
  echo "Ferdium .rpm not found. Please download manually from https://github.com/ferdium/ferdium-app/releases"
fi

echo "------------------------------------------------------"
echo "All tools installed successfully!"
echo "Restart your terminal or system to apply shell changes."
echo "To apply Powerlevel10k, type: 'p10k configure'"
