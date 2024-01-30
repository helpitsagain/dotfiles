#!bin/bash

read -p "Do you want to install yay? [Y/n] " -i "Y" install_yay
case $install_yay in 
  "Y"|"y"|"") sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si ;
    sleep 1 ;
    yay -Y --gendb &*& yay -Syu --devel; break;;
  "N"|"n") echo "Skipping installation";;
esac

read -p "Do you want to install neovim, tmux and ranger? [Y/n] " -i "Y" install_pkgs
case $install_pkgs in 
  "Y"|"y"|"") echo "Installing packages"; sudo pacman -S nvim tmux ranger; break;;
  "N"|"n") echo "Skipping packages";;
esac

read -p "Do you want to install Oh My Posh? [Y/n] " -i "Y" install_omp
case $install_omp in 
  "Y"|"y"|"") echo "Installing Oh My Posh!"; 
    mkdir $HOME/bin
	  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/bin;
    cp -r config/oh-my-posh $HOME/.config/;;
  "N"|"n") echo "Skipping Oh My Posh!";;
esac

echo "Copying .bashrc to $HOME"
cp -b home/bashrc $HOME/.bashrc

echo "Copying .bash_aliases to $HOME"
cp -b home/bash_aliases $HOME/.bash_aliases

source $HOME/.bashrc
source $HOME/.bash_aliases

echo "Copying lazy.nvim to $HOME"
cp -rb home/lazy.nvim $HOME/

echo "Copying config/nvim to $HOME/.config"
cp -rb ./config/nvim $HOME/.config/nvim

echo "Copying config/tmux to $HOME/.config"
cp -rb ./config/tmux $HOME/.config/tmux

echo "Copying config/ranger to $HOME/.config"
cp -rb ./config/ranger $HOME/.config/ranger
export RANGER_LOAD_DEFAULT_RC=false

