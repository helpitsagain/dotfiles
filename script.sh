#!/bin/bash

current_dir="$(pwd)"

dotfiles_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# distro=$(lsb_release -i | cut -f 2-)
if command -v apt &>/dev/null; then
  distro="Ubuntu"
elif command -v pacman &>/dev/null; then
  distro="Arch"
elif command -v yum &>/dev/null; then
  distro="RHEL"
fi

if [ "$distro" = "Arch" ]; then
  while true; do
    read -p "Do you want to install yay? [y/N] " install_yay
    case "$install_yay" in
    [Yy]*)
      cd "$HOME"
      sudo pacman -S --needed git base-devel
      git clone https://aur.archlinux.org/yay.git
      cd yay && makepkg -si
      sleep 1
      yay -Y --gendb
      yay -Syu --devel
      cd "$dotfiles_dir"
      break
      ;;
    [Nn]* | "")
      echo "Skipping yay"
      break
      ;;
    *)
      echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
      ;;
    esac
  done
fi

while true; do
  read -p "Do you want to install packages? [y/N] " install_pkgs
  case "${install_pkgs,,}" in
  [Yy]*)
    echo "Installing packages"
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install nodejs npm neovim tmux ranger neofetch
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S nodejs npm neovim tmux ranger neofetch
    elif [ "$distro" = "RHEL" ]; then
      sudo yum install nodejs npm neovim tmux ranger neofetch
    fi
    break
    ;;
  [Nn]* | "")
    echo "Skipping packages"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done

while true; do
  read -p "Do you want to install oh-my-posh? [y/N] " install_omp
  case "${install_omp,,}" in
  [Yy]*)
    echo "Installing oh-my-posh"
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install unzip
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S unzip
    elif [ "$distro" = "RHEL" ]; then
      sudo yum install unzip
    fi
    mkdir "$HOME/bin"
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/bin"
    cp -r config/oh-my-posh "$HOME/.config/"
    break
    ;;
  [Nn]* | "")
    echo "Skipping oh-my-posh"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done

cd "$dotfiles_dir"

echo "Copying .bashrc to $HOME"
cp -b home/bashrc "$HOME/.bashrc"

echo "Copying .bash_aliases to $HOME"
cp -b home/bash_aliases "$HOME/.bash_aliases"

source "$HOME/.bashrc"
source "$HOME/.bash_aliases"

echo "Copying config/nvim to $HOME/.config"
cp -rb ./config/nvim "$HOME/.config/"

echo "Copying config/tmux to $HOME/.config"
cp -rb ./config/tmux "$HOME/.config/"
echo "Installing tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo "Copying config/ranger to $HOME/.config"
cp -rb ./config/ranger "$HOME/.config/"
export RANGER_LOAD_DEFAULT_RC=false

cd "$current_dir"
