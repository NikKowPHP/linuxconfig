export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  vi-mode
  history-substring-search
)

ZSH_THEME="agnoster"

eval `dircolors ~/.dir_colors/dircolors`

prompt_context() {} 

# Large history file
HISTSIZE=10000000
SAVEHIST=10000000

# Prevent duplicates in history
setopt hist_ignore_all_dups hist_save_nodups


source $ZSH/oh-my-zsh.sh

# Colors:
eval `dircolors ~/.dir_colors/dircolors`


export FZF_BASE="/home/.fzf"

export PATH="$PATH:/home/kasjer/Downloads/projects/flutter/bin/flutter"

export http_proxy=http://172.16.2.254:3128
export https_proxy=http://172.16.2.254:3128
export no_proxy="127.0.0.1, localhost"

source /home/kasjer/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/kasjer/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=$PATH:/sbin:/usr/sbin

# Assuming SDK is located at ~/Android/Sdk
export ANDROID_HOME=/home/kasjer/Android/Sdk  
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export PATH="$PATH:/usr/bin"
export PATH="$PATH:/home/kasjer/Downloads/projects/flutter/bin"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

export PATH="$PATH":"$HOME/.pub-cache/bin"
export MYVIMRC=$HOME/.config/nvim/init.lua  # Or init.vim
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
alias cursor='/home/kasjer/.local/share/cvm/active'
alias cvm="$HOME/cvm.sh"
export PATH="$PATH":"$HOME"
