#!/bin/bash

# Exit if any command fails
set -e

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing core tools: git, curl, wget..."
sudo pacman -S --noconfirm git curl wget

echo "Installing Firefox..."
sudo pacman -S --noconfirm firefox

echo "Installing Wine (64-bit and 32-bit)..."
sudo pacman -S --noconfirm wine

echo "Installing Zsh..."
sudo pacman -S --noconfirm zsh
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

echo "Installing Fastfetch (Neofetch alternative)..."
sudo pacman -S --noconfirm fastfetch

echo "Installing GCC, G++, and build tools..."
sudo pacman -S --noconfirm base-devel

echo "Installing OpenJDK 17 (Java)..."
sudo pacman -S --noconfirm jdk-openjdk

echo "Installing Visual Studio Code..."
if ! command -v code &>/dev/null; then
  echo "Installing VS Code from AUR via yay..."
  yay -S --noconfirm visual-studio-code-bin
fi

echo "Installing CopyQ..."
sudo pacman -S --noconfirm copyq

echo "Installing GNOME Boxes..."
sudo pacman -S --noconfirm gnome-boxes

echo "Installing Flatpak and Flathub..."
sudo pacman -S --noconfirm flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Bottles via Flatpak..."
flatpak install -y flathub com.usebottles.bottles

echo "Installing VLC media player..."
sudo pacman -S --noconfirm vlc

echo "Installing GIMP..."
sudo pacman -S --noconfirm gimp

echo "Installing KDE Connect..."
sudo pacman -S --noconfirm kdeconnect

echo "Installing GitHub CLI..."
if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI from AUR..."
  yay -S --noconfirm github-cli
fi

echo "Installing Ferdium (.deb equivalent)..."
FERDIUM_URL=$(curl -s https://api.github.com/repos/ferdium/ferdium-app/releases/latest \
  | grep "browser_download_url.*\.AppImage" \
  | cut -d '"' -f 4 | grep x86_64 | head -n 1)

if [ -n "$FERDIUM_URL" ]; then
  wget -O ferdium.AppImage "$FERDIUM_URL"
  chmod +x ferdium.AppImage
  sudo mv ferdium.AppImage /usr/local/bin/ferdium
else
  echo "Ferdium AppImage not found. Please download manually from https://github.com/ferdium/ferdium-app/releases"
fi

echo "------------------------------------------------------"
echo "All tools installed successfully!"
echo "Restart your terminal or system to apply shell changes."
echo "To apply Powerlevel10k, type: 'p10k configure'"
