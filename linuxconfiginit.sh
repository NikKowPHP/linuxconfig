#!/bin/bash

# Script to install specified packages, zsh with Oh My Zsh, vim, and configure git on Ubuntu.
# Includes proxy management based on command-line arguments.

# Function to set proxy environment variables
set_proxy() {
  export http_proxy="http://172.16.2.254:3128"
  export https_proxy="http://172.16.2.254:3128"
  export no_proxy="127.0.0.1, localhost"
  echo "Proxy settings enabled."
}

# Function to unset proxy environment variables
unset_proxy() {
  unset http_proxy
  unset https_proxy
  unset no_proxy
  echo "Proxy settings disabled."
}

# Check for command-line argument to set proxy
if [[ "$1" == "--proxy" && "$2" == "setup" ]]; then
  set_proxy
fi

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
    if command -v "code" &> /dev_null; then
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

# Install PHP and Composer
echo "--- Installing PHP and Composer ---"
install_if_missing php
install_if_missing php-cli
install_if_missing php-curl
install_if_missing php-mbstring
install_if_missing php-xml
install_if_missing php-zip
if ! command -v composer &> /dev/null; then
    echo "Installing Composer..."
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
else
    echo "Composer is already installed. Skipping..."
fi

# Install PostgreSQL
echo "--- Installing PostgreSQL ---"
install_if_missing postgresql
install_if_missing postgresql-contrib

# Install ngrok
echo "--- Installing ngrok ---"
if ! command -v ngrok &> /dev/null; then
    echo "Installing ngrok..."
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok.zip
    sudo unzip -o ngrok.zip -d /usr/local/bin
    rm ngrok.zip
else
    echo "ngrok is already installed. Skipping..."
fi

# Install Node.js LTS (already handled by install_if_missing nodejs, assuming default apt is LTS or user manages versions)
echo "--- Installing Node.js LTS (via apt) ---"
# Specific steps for LTS might be needed if default apt is not LTS

# Install Ruby LTS (via apt)
echo "--- Installing Ruby LTS (via apt) ---"
install_if_missing ruby
# Specific steps for LTS might be needed if default apt is not LTS or user manages versions

# Install Go LTS (via apt)
echo "--- Installing Go LTS (via apt) ---"
install_if_missing golang-go
# Specific steps for LTS might be needed if default apt is not LTS or user manages versions

# Install Python with package manager (pip is already installed)
echo "--- Installing Python with package manager (pip) ---"
# python3-pip is already handled by install_if_missing

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
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
    source ~/.zshrc
    npm install -g create-next-app
else
    echo "npm is not installed, skipping npm configurations."
fi

# Check for and install code if it's not already available
install_code

# --- Install Homebrew (Linuxbrew) ---
echo "--- Installing Homebrew (Linuxbrew) ---"
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH for the current session
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed. Skipping..."
fi

# --- Install Android Studio and Flutter ---
echo "--- Installing Android Studio and Flutter ---"

# Install required libraries for Android Studio
sudo apt-get update
sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 lib32stdc++6

# Download and extract Android Studio (using a recent version, may need updating)
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.2.1.23/android-studio-2023.2.1.23-linux.tar.gz"
ANDROID_STUDIO_TAR="android-studio.tar.gz"
ANDROID_STUDIO_DIR="$HOME/android-studio"

if [ ! -d "$ANDROID_STUDIO_DIR" ]; then
    echo "Downloading Android Studio..."
    wget -O $ANDROID_STUDIO_TAR $ANDROID_STUDIO_URL
    echo "Extracting Android Studio..."
    tar -xzf $ANDROID_STUDIO_TAR -C $HOME
    rm $ANDROID_STUDIO_TAR
    echo "Android Studio extracted to $ANDROID_STUDIO_DIR"
    echo "Please run $ANDROID_STUDIO_DIR/bin/studio.sh to complete the setup and install the Android SDK."
else
    echo "Android Studio directory already exists. Skipping download and extraction."
fi

# Download and extract Flutter SDK (using a recent stable version, may need updating)
FLUTTER_URL="https://storage.googleapis.com/flutter_releases/releases/stable/linux/flutter_linux_3.22.0-stable.tar.xz"
FLUTTER_TAR="flutter.tar.xz"
FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
    echo "Downloading Flutter SDK..."
    wget -O $FLUTTER_TAR $FLUTTER_URL
    echo "Extracting Flutter SDK..."
    tar -xf $FLUTTER_TAR -C $HOME
    rm $FLUTTER_TAR
    echo "Flutter SDK extracted to $FLUTTER_DIR"
    # Add Flutter to PATH (this is also handled in .zshrc, but good to have here)
    export PATH="$PATH:$FLUTTER_DIR/bin"
    echo "Flutter bin directory added to PATH for this session."
else
    echo "Flutter directory already exists. Skipping download and extraction."
    # Ensure Flutter is in PATH if directory exists
    export PATH="$PATH:$FLUTTER_DIR/bin"
fi

# Run flutter doctor to check for dependencies
echo "Running flutter doctor..."
flutter doctor

echo "--- End of Android Studio and Flutter Installation ---"

# --- Install Fira Code Nerd Fonts ---
echo "--- Installing Fira Code Nerd Fonts ---"

# Create fonts directory if it doesn't exist
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
mkdir -p $FONT_DIR

# Download Fira Code Nerd Font
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
FONT_ZIP="FiraCode.zip"

echo "Downloading Fira Code Nerd Font..."
wget -O $FONT_ZIP $FONT_URL

echo "Extracting fonts..."
unzip -o $FONT_ZIP -d $FONT_DIR

echo "Cleaning up..."
rm $FONT_ZIP

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "--- End of Fira Code Nerd Fonts Installation ---"


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
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
plugins=(
  git
  zsh-autosuggestions
  vi-mode
  history-substring-search
)

ZSH_THEME="agnoster"

# eval \`dircolors ~/.dir_colors/dircolors\`

# prompt_context() {}

# Large history file
HISTSIZE=10000000
SAVEHIST=10000000

# Prevent duplicates in history
setopt hist_ignore_all_dups hist_save_nodups

source $ZSH/oh-my-zsh.sh

# Colors:
# eval \`dircolors ~/.dir_colors/dircolors\`

# Install fzf (if not already installed)
if ! [ -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
export FZF_BASE="/home/.fzf"

# Install zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING_DIR="$HOME/zsh-syntax-highlighting"
if ! [ -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
fi

export PATH="$PATH:$HOME/flutter/bin" # Updated Flutter path
export PATH="$PATH:/sbin:/usr/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$HOME"

# Assuming SDK is located at ~/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools"



source $ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

export MYVIMRC=$HOME/.config/nvim/init.lua  # Or init.vim
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
# eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
alias cursor="$HOME/.local/share/cvm/active"
alias cvm="$HOME/cvm.sh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=~/.npm-global/bin:$PATH

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
EOF

echo "Zsh configured based on your existing settings."

# Clone the missing plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.ohmyzsh/custom}/plugins/zsh-vi-mode
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
