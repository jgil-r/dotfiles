export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=$PATH:/usr/local/go/bin

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chuy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias config='/usr/bin/git --git-dir=/home/chuy/.cfg/ --work-tree=/home/chuy'
alias vim="nvim"
alias l="ls -la"

alias zs="source ~/.zshrc"
alias zz="vim ~/.zshrc"
alias nn="vim ~/.config/nvim/init.vim"
alias st="vim ~/.config/starship/starship.toml"
alias aa="vim ~/.config/alacritty/alacritty.yml"
alias ii="vim ~/.config/i3/config"

TMUX_CONFIG="~/.config/tmux/.tmux.conf"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"
alias tt="vim $TMUX_CONFIG"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(starship init zsh)"
