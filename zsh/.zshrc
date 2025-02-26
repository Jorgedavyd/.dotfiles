export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-256color
    zsh-syntax-highlighting
    zsh-vim-mode
    docker
    docker-compose
    pip
    python
    tmux
    z
)

VIM_MODE_VICMD_KEY='^C'
MODE_CURSOR_VIINS="#fe8019 steady bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #fe8019"
MODE_CURSOR_VICMD="#fe8019 steady block"
MODE_CURSOR_SEARCH="#fe8019 steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady block"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #fe8019"

source $ZSH/oh-my-zsh.sh

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
HISTSIZE=1000
SAVEHIST=2000

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='nvim'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history 1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

export PATH=~/opt/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=~/opt/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH=~/lib/libtorch/lib:$PATH
export CPLUS_INCLUDE_PATH=~/lib/libtorch/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=~/lib/libtorch/lib:$LIBRARY_PATH

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

PATH="$PATH:$HOME/.local/scripts/"

bindkey -s '^F' 'tmux-sessionizer^M'
bindkey -s '^O' 'pdf-fzf^M'
bindkey -s '^S' 'project^M'
bindkey -s '^G' 'lazygit^M'
bindkey -s '^T' 'tex-template-fzf^M'
bindkey '^Y' autosuggest-accept

bindkey -s '^E' 'source /data/env/bin/activate && clear^M'

bindkey -r '^H'
bindkey -r '^J'
bindkey -r '^K'
bindkey -r '^L'

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec Hyprland
fi

