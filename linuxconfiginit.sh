#!/bin/bash

# Script to install specified packages, zsh with Oh My Zsh, vim, and configure git on Ubuntu.

# Update the package list
sudo apt update

# Function to handle optional installations
install_if_missing() {
  local package="$1"
  if ! command -v "$package" &> /dev/null; then
    echo "Installing $package..."
    sudo apt install -y "$package"
  else
    echo "$package is already installed. Skipping..."
  fi
}
# Function to handle code installations
install_code() {
    if command -v "code" &> /dev/null; then
      echo "Installing Cody-AI VS Code extension..."
    code --install-extension sourcegraph.cody-ai
    else
      echo "Visual Studio code is not installed, skipping cody install"
    fi
}

# Install specified packages only if not already installed
install_if_missing neovim
install_if_missing nodejs
install_if_missing pulseeffects
install_if_missing redshift
install_if_missing terminator
install_if_missing neofetch
install_if_missing copyq
install_if_missing bumblebee-status
install_if_missing thunar
install_if_missing rofi
install_if_missing zsh
install_if_missing vim
install_if_missing git
install_if_missing openbox
install_if_missing tint2
install_if_missing docker.io
install_if_missing  python3-pip
install_if_missing  flameshot
install_if_missing  npm



echo " -- docker intallation with docker compose-- " 
if ! command -v docker-compose &> /dev/null; then
    wget https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64
    sudo mv docker-compose-linux-x86_64 /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
fi

sudo usermod -aG docker $USER
# Add current user to docker group to avoid using sudo with docker
if ! groups $USER | grep -q docker; then
    echo "Adding user $USER to docker group..."
    sudo usermod -aG docker $USER
    newgrp docker
    echo "Please log out and back in for the changes to take effect for docker to work without sudo"
fi


# Check for and install npm if it's not already available
if command -v npm &> /dev/null; then
    echo "npm is installed, configuring it..."
    mkdir -p ~/.npm-global
    npm config set prefix '~/.npm-global'
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
    npm install -g create-next-app
else
    echo "npm is not installed, skipping npm configurations."
fi

# Check for and install code if it's not already available
install_code

# --- Zsh and Oh My Zsh Installation ---

# Check if Zsh is already the default shell
if [[ "$SHELL" != "/bin/zsh" && "$SHELL" != "/usr/bin/zsh" ]]; then
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # Change the default shell to zsh
  sudo chsh -s $(which zsh)
  echo "Zsh installed and set as the default shell."
else
  echo "Zsh is already the default shell. Skipping installation."
fi

# --- Configure Zsh based on your existing .zshrc ---

# Check if .zshrc already exists and back it up if it does
if [ -f ~/.zshrc ]; then
  echo "Existing .zshrc found. Backing up to ~/.zshrc.bak"
  mv ~/.zshrc ~/.zshrc.bak
fi

# Create a new .zshrc file
cat << 'EOF' > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  vi-mode
  history-substring-search
)

ZSH_THEME="agnoster"

eval \`dircolors ~/.dir_colors/dircolors\`

prompt_context() {} 

# Large history file
HISTSIZE=10000000
SAVEHIST=10000000

# Prevent duplicates in history
setopt hist_ignore_all_dups hist_save_nodups

source $ZSH/oh-my-zsh.sh

# Colors:
eval \`dircolors ~/.dir_colors/dircolors\`

# Install fzf (if not already installed)
if ! [ -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
export FZF_BASE="/home/.fzf"

# Install zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING_DIR="/home/kasjer/zsh-syntax-highlighting"
if ! [ -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
fi

export PATH="$PATH:/home/kasjer/Downloads/projects/flutter/bin/flutter"
export PATH="$PATH:/sbin:/usr/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/home/kasjer/Downloads/projects/flutter/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$HOME"

# Assuming SDK is located at ~/Android/Sdk
export ANDROID_HOME=/home/kasjer/Android/Sdk  
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools



source $ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

export MYVIMRC=$HOME/.config/nvim/init.lua  # Or init.vim
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
alias cursor='/home/kasjer/.local/share/cvm/active'
alias cvm="$HOME/cvm.sh"

EOF

echo "Zsh configured based on your existing settings."

# Clone the missing plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# --- End of Zsh Configuration ---

# --- Git Configuration ---

# Set user email
git config --global user.email "nik.kow@outlook.com"
git config --global user.name "NikKowPHP"

# Generate SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Generating new SSH key..."
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
else
  echo "SSH key already exists. Skipping generation."
fi

# Display the public key
echo "Your SSH public key is:"
cat ~/.ssh/id_rsa.pub

# --- End of Git Configuration ---


echo "Installation and configuration complete!"

# Optional: Clean up downloaded packages
sudo apt autoremove -y
sudo apt clean

echo "Clean up complete (optional)!"
