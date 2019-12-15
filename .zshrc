# Definitive (hopefully) configuration file for my zsh shell
# Author: Mango

# Most of the following was taked from here (luke smith) https://www.youtube.com/watch?v=eLEo4OQ-cuQ
# Enable colors and change prompt

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.cache/zsh/history 

# Basic auto/tab complete:
# [TODO] expand and explore
autoload -U compinit
zstyle ":completition:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# vi mode 
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char



# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
   echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
      [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
      [[ $1 = 'beam' ]]; then
     echo -ne '\e[5 q'
  fi
  }
zle -N zle-keymap-select
zle-line-init() {
    #zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Aliases
alias battery=acpi

fpath+=("$HOME/.zsh/pure")

# zsh options
setopt auto_cd

# .zshrc
autoload -U promptinit; promptinit
prompt pure

# settings for https://github.com/ssh0/dot
export DOT_REPO="https://github.com/mango915/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"
fpath=($HOME/.zsh/dot $fpath)  # <- for completion
source $HOME/.zsh/dot/dot.sh

# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

 [[ -s /home/mango/.autojump/etc/profile.d/autojump.sh ]] && source /home/mango/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

