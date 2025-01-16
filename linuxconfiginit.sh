#!/bin/bash

# Script to install specified packages, zsh with Oh My Zsh, vim, and configure git on Ubuntu.

# Update the package list
sudo apt update

# Install the specified packages
sudo apt install -y \
  neovim \
  code \
  google-cloud-sdk \
  nodejs \
  npm \
  pulseeffects \
  redshift \
  terminator \
  neofetch \
  copyq \
  bumblebee-status \
  thunar \
  rofi \
  zsh \
  vim \
  git

# Install Cody-AI VS Code extension (assuming code is installed)
code --install-extension sourcegraph.cody-ai

# Set up npm for Next.js (if not already configured)
# This sets the global node_modules directory to ~/.npm-global
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc

# Source your .bashrc to apply changes immediately
source ~/.bashrc

# Install Next.js CLI tools globally
npm install -g create-next-app

# --- Zsh and Oh My Zsh Installation ---

# Check if Zsh is already the default shell
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/bin/zsh" ]; then
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # Change the default shell to zsh
  chsh -s $(which zsh)

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

# Generate SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_rsa ]; hen
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

echo "Clean up complete (optional)!"t


