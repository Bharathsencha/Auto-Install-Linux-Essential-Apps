#!/bin/bash

# Exit if any command fails
set -e

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing core tools: git, curl, wget..."
sudo apt install -y git curl wget

echo "Installing Firefox..."
sudo apt install -y firefox

echo "Installing Wine (64-bit and 32-bit)..."
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine64 wine32

echo "Installing Zsh..."
sudo apt install -y zsh
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
sudo apt install -y neofetch

echo "Installing GCC, G++, and build tools..."
sudo apt install -y build-essential

echo "Installing OpenJDK 17 (Java)..."
sudo apt install -y openjdk-17-jdk

echo "Installing Visual Studio Code..."
if ! command -v code &>/dev/null; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code
  rm microsoft.gpg
fi

echo "Installing CopyQ..."
sudo apt install -y copyq

echo "Installing GNOME Boxes..."
sudo apt install -y gnome-boxes

echo "Installing Flatpak and Flathub..."
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Bottles via Flatpak..."
flatpak install -y flathub com.usebottles.bottles

echo "Installing VLC media player..."
sudo apt install -y vlc

echo "Installing GIMP..."
sudo apt install -y gimp

echo "Installing GitHub CLI..."
type -p curl >/dev/null || sudo apt install -y curl
curl -fsSL https://cli.github.com/packa#!/bin/bash

# Exit if any command fails
set -e

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing core tools: git, curl, wget..."
sudo apt install -y git curl wget

echo "Installing Firefox..."
sudo apt install -y firefox

echo "Installing Wine (64-bit and 32-bit)..."
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine64 wine32

echo "Installing Zsh..."
sudo apt install -y zsh
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
sudo apt install -y neofetch

echo "Installing GCC, G++, and build tools..."
sudo apt install -y build-essential

echo "Installing OpenJDK 17 (Java)..."
sudo apt install -y openjdk-17-jdk

echo "Installing Visual Studio Code..."
if ! command -v code &>/dev/null; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code
  rm microsoft.gpg
fi

echo "Installing CopyQ..."
sudo apt install -y copyq

echo "Installing GNOME Boxes..."
sudo apt install -y gnome-boxes

echo "Installing Flatpak and Flathub..."
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Bottles via Flatpak..."
flatpak install -y flathub com.usebottles.bottles

echo "Installing VLC media player..."
sudo apt install -y vlc

echo "Installing GIMP..."
sudo apt install -y gimp

echo "Installing KDE Connect..."
sudo apt install -y kdeconnect


echo "Installing GitHub CLI..."
type -p curl >/dev/null || sudo apt install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh

echo "Installing Ferdium (.deb)..."
FERDIUM_URL=$(curl -s https://api.github.com/repos/ferdium/ferdium-app/releases/latest \
  | grep "browser_download_url.*\.deb" \
  | cut -d '"' -f 4 | grep amd64 | head -n 1)

if [ -n "$FERDIUM_URL" ]; then
  wget -O ferdium.deb "$FERDIUM_URL"
  sudo apt install -y ./ferdium.deb
  rm ferdium.deb
else
  echo "Ferdium .deb not found. Please download manually from https://github.com/ferdium/ferdium-app/releases"
fi

echo "------------------------------------------------------"
echo "All tools installed successfully!"
echo "Restart your terminal or system to apply shell changes."
echo "To apply Powerlevel10k, type: 'p10k configure'"ges/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh

echo "Installing Ferdium (.deb)..."
FERDIUM_URL=$(curl -s https://api.github.com/repos/ferdium/ferdium-app/releases/latest \
  | grep "browser_download_url.*\.deb" \
  | cut -d '"' -f 4 | grep amd64 | head -n 1)

if [ -n "$FERDIUM_URL" ]; then
  wget -O ferdium.deb "$FERDIUM_URL"
  sudo apt install -y ./ferdium.deb
  rm ferdium.deb
else
  echo "Ferdium .deb not found. Please download manually from https://github.com/ferdium/ferdium-app/releases"
fi

echo "------------------------------------------------------"
echo "All tools installed successfully!"
echo "Restart your terminal or system to apply shell changes."
echo "To apply Powerlevel10k, type: 'p10k configure'"
