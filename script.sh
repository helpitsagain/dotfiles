#!bin/bash

current_dir=$(pwd)

dotfiles_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

read -p "Do you want to install yay? [y/N] " -i "N" install_yay
case $install_yay in
"Y" | "y")
  cd $HOME ;
  sudo pacman -S --needed git base-devel ;
  git clone https://aur.archlinux.org/yay.git ;
  cd yay && makepkg -si ;
  sleep 1 ;
  yay -Y --gendb ;
  yay -Syu --devel ;
  cd $dotfiles_dir ;;
"N" | "n" | "") echo "Skipping yay" ;;
esac

read -p "Do you want to install packages? [y/N] " -i "N" install_pkgs
case $install_pkgs in
"Y" | "y")
  echo "Installing packages" ;
  sudo pacman -S nodejs npm neovim tmux ranger ;;
"N" | "n" | "") echo "Skipping packages" ;;
esac

read -p "Do you want to install oh-my-posh? [y/N] " -i "n" install_omp
case $install_omp in
"Y" | "y")
  echo "Installing oh-my-posh" ;
  sudo pacman install unzip ;
  mkdir $HOME/bin ;
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/bin ;
  cp -r config/oh-my-posh $HOME/.config/ ;;
"N" | "n" | "") echo "Skipping oh-my-posh" ;;
esac

cd $dotfiles_dir

echo "Copying .bashrc to $HOME"
cp -b home/bashrc $HOME/.bashrc

echo "Copying .bash_aliases to $HOME"
cp -b home/bash_aliases $HOME/.bash_aliases

source $HOME/.bashrc
source $HOME/.bash_aliases

echo "Copying config/nvim to $HOME/.config"
cp -rb ./config/nvim $HOME/.config/

echo "Copying config/tmux to $HOME/.config"
cp -rb ./config/tmux $HOME/.config/

echo "Copying config/ranger to $HOME/.config"
cp -rb ./config/ranger $HOME/.config/
export RANGER_LOAD_DEFAULT_RC=false

cd $current_dir

