#!/bin/bash

current_dir="$(pwd)"

dotfiles_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

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
      cd "$HOME";
      sudo pacman -S --needed git base-devel;
      git clone https://aur.archlinux.org/yay.git;
      cd yay && makepkg -si;
      sleep 1;
      yay -Y --gendb;
      yay -Syu --devel;
      cd "$dotfiles_dir";
      break
      ;;
    [Nn]* | "")
      echo "Skipping yay";
      break
      ;;
    *)
      echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
      ;;
    esac
  done
fi

while true do
  read -p "Do you want to install dependencies? [y/N]" install_dependencies
  case "$install_dependencies" in 
    [Yy]*)
      echo "Installing dependencies";
      if [ "$distro" = "Ubuntu" ]; then
       sudo apt install -y git stow unzip nodejs npm
      elif [ "$distro" = "Arch" ]; then
        sudo pacman -S git stow unzip nodejs npm
      elif [ "$distro" = "RHEL" ]; then
        sudo yum install -y git stow unzip nodejs npm
      fi
    break
    ;;
  [Nn]* | "")
    echo "Skipping dependencies"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done


while true; do
  read -p "Do you want to install packages? [y/N] " install_pkgs
  case "$install_pkgs" in
  [Yy]*)
    echo "Installing packages"
    if [ "$distro" = "Ubuntu" ]; then
      sudo add-apt-repository ppa:neovim-ppa/unstable
      sudo apt update
      sudo apt install -y neovim tmux ranger neofetch
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S neovim tmux ranger neofetch
    elif [ "$distro" = "RHEL" ]; then
      sudo yum install -y neovim tmux ranger neofetch
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

