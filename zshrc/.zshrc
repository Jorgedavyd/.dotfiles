case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS

HISTSIZE=1000
SAVEHIST=2000

setopt CHECK_WINSIZE

autoload -U colors && colors
if [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
    alias ls='ls --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)

export PATH=~/opt/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=~/opt/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export PATH=~/lib/libtorch/lib:$PATH
export CPLUS_INCLUDE_PATH=~/lib/libtorch/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=~/lib/libtorch/lib:$LIBRARY_PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # Loads nvm bash_completion

PATH="$PATH:$HOME/.local/scripts/"

bindkey '^F' tmux-sessionizer-env-projects
bindkey '^O' tmux-sessionizer-pdf
bindkey '^S' project
bindkey '^G' lazygit

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    # exec startx
    exec Hyprland
fi

alias vi='nvim'

