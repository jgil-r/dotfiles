export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH="$HOME/neovim/bin:$PATH"
export GOPATH=~/go
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin:$GOBIN"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"

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
alias n="vim ~/.config/nvim"
alias nn="vim ~/.config/nvim/init.vim"
alias todo="vim ~/Documents/notes"
alias st="vim ~/.config/starship/starship.toml"
alias ii="vim ~/.config/i3/config"
alias ib="vim ~/.config/i3status/config"

TMUX_CONFIG="~/.config/tmux/.tmux.conf"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"
alias tt="vim $TMUX_CONFIG"

alias debins="sudo gdebi-gtk"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(starship init zsh)"
