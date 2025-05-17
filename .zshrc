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

export PATH="$PATH:$HOME/Downloads/projects/flutter/bin/flutter"

source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=$PATH:/sbin:/usr/sbin

# Assuming SDK is located at ~/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export PATH="$PATH:/usr/bin"
export PATH="$PATH:$HOME/Downloads/projects/flutter/bin"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

export PATH="$PATH":"$HOME/.pub-cache/bin"
export MYVIMRC=$HOME/.config/nvim/init.lua  # Or init.vim
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
alias cursor='$HOME/.local/share/cvm/active'
alias cvm="$HOME/cvm.sh"
export PATH="$PATH":"$HOME"

