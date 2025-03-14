case $- in
  *i*) ;;
    *) return;;
esac

export OSH=~/.oh-my-bash

OSH_THEME="font"
OMB_CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
OMB_USE_SUDO=false
OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable

completions=(
  git
  composer
  ssh
  pip
)

plugins=(
  git
  bashmarks
  tmux-autoattach
)

if [ "$DISPLAY" ] || [ "$SSH" ]; then
    plugins+=(tmux-autoattach)
fi

## oh-my-bash support
source "$OSH"/oh-my-bash.sh

## bash completion engines
if [ -d "$HOME/.bash_completion" ]; then
  for file in "$HOME/.bash_completion/"*; do
    [ -f "$file" ] && source "$file"
  done
fi

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

## Bindings
bind '"^F" "tmux-sessionizer^M"'
bind '"^O" "pdf-fzf^M"'
bind '"^S" "project^M"'
bind '"^T" "tex-template-fzf^M"'
bind '"^E" "source /data/env/bin/activate && clear^M"'

## Aliases
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# SSH and Compile flags
export SSH_KEY_PATH="~/.ssh/rsa_id"
export ARCHFLAGS="-arch x86_64"

## Vim as a life-style
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
    alias vi='vim'
else
    export EDITOR=nvim
    alias vi='nvim'
fi

# CUDA setup
export CUDA_PATH=/opt/cuda
export PATH=$CUDA_PATH/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
export CPATH=$CUDA_HOME/include:$CPATH
export LIBRARY_PATH=$CUDA_HOME/lib64:$LIBRARY_PATH

# cuDNN setup
export CUDNN_PATH=/usr/lib
export LD_LIBRARY_PATH=$CUDNN_PATH:$LD_LIBRARY_PATH

# NVIDIA Visual Profiler
alias nvp='nvvp -vm /usr/lib/jvm/java-8-openjdk/jre/bin/java'

# NVM setup
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Setting up scripts
PATH="$PATH:$HOME/.local/scripts/"
