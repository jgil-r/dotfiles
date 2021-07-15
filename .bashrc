# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH="$HOME/.local/bin/:$PATH"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin:$GOBIN"

# ---------- Aliases ----------
TMUX_CONFIG="$HOME/.config/tmux/.tmux.conf"

alias config='/usr/bin/git --git-dir=/home/chuy/.cfg/ --work-tree=/home/chuy'
alias vim="nvim"
alias bs="source $HOME/.bashrc"
alias bb="vim $HOME/.bashrc"
alias nn="vim $HOME/.config/nvim/init.vim"
alias nd="vim $HOME/.config/nvim"
alias nt="vim $HOME/notes"
alias tt="vim $TMUX_CONFIG"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

. "$HOME/.cargo/env"
