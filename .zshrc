# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt beep nomatch correctall
unsetopt autocd extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/luc/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# oh my posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/catppuccin_mocha.omp.json)"

# aliases
# source $HOME/.zsh_aliases
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

