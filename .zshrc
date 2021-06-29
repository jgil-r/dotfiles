function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('%F{red}$branch%f')'
  fi
}

setopt prompt_subst

export PS1="[%~]\$(git_branch_name)$ "
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export EDITOR=/usr/bin/nvim
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

alias zs="source $HOME/.zshrc"
alias zz="vim $HOME/.zshrc"

alias n="vim $HOME/.config/nvim"

alias aa="vim $HOME/.config/alacritty/alacritty.yml"
alias ii="vim $HOME/.config/i3"
alias todo="vim $HOME/todo"

TMUX_CONFIG="$HOME/.config/tmux/.tmux.conf"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"
alias tt="vim $TMUX_CONFIG"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fpath+=${ZDOTDIR:-~}/.zsh_functions
