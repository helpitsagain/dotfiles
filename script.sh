#!bin/bash

echo "Installing packages..."
yay -S nvim tmux ranger

echo "Copying .bashrc to $HOME"
cp -b home/bashrc $HOME/.bashrc

echo "Copying .bash_aliases to $HOME"
cp -b home/bash_aliases $HOME/.bash_aliases

echo "Copying lazy.nvim to $HOME"
cp -rb home/lazy.nvim $HOME/

echo "Copying config/nvim to $HOME/.config"
cp -rb ./config/nvim $HOME/.config/nvim

echo "Copying config/tmux to $HOME/.config"
cp -rb ./config/tmux $HOME/.config/tmux

echo "Copying config/ranger to $HOME/.config"
cp -rb ./config/ranger $HOME/.config/ranger
export RANGER_LOAD_DEFAULT_RC=false
