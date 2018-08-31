ZSH_THEME="bira"
ZSH=/usr/share/oh-my-zsh/
DISABLE_AUTO_UPDATE="true"
plugins=(git)

# Aliases
alias mocp='$HOME/.config/awesome/scripts/mocp-lastfm.py -d; $HOME/.config/awesome/scripts/mocp-librefm.py -d; mocp'

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

