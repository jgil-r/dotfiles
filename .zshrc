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

kitty + complete setup zsh | source /dev/stdin

alias config='/usr/bin/git --git-dir=/home/chuy/.cfg/ --work-tree=/home/chuy'
alias vim="nvim"
alias l="ls -la"

alias zs="source ~/.zshrc"
alias zz="vim ~/.zshrc"

alias n="vim ~/.config/nvim"
alias nn="vim ~/.config/nvim/init.vim"

alias kk="vim ~/.config/kitty/kitty.conf"
alias ii="vim $HOME/.config/i3"
alias notes="vim ~/notes"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
