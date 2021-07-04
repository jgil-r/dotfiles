export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export PATH="$HOME/.local/bin/:$PATH"
export GOPATH="$HOME/go"
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
alias l="ls -AC"
alias zs="source $HOME/.zshrc"

TMUX_CONFIG="$HOME/.config/tmux/.tmux.conf"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(starship init zsh)"
