#!/bin/bash

current_dir="$(pwd)"

dotfiles_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if command -v apt &>/dev/null; then
  distro="Ubuntu"
elif command -v pacman &>/dev/null; then
  distro="Arch"
elif command -v dnf &>/dev/null; then
  distro="Fedora"
elif command -v yum &>/dev/null; then
  distro="RHEL"
fi

if [ "$distro" = "Arch" ]; then
  while true; do
    echo "Do you want to install yay? [y/N]"
    read install_yay
    case "$install_yay" in
    [Yy]*)
      cd "$HOME"
      sudo pacman -S --needed git base-devel
      git clone https://aur.archlinux.org/yay.git "$HOME/yay"
      cd "$HOME/yay" && makepkg -si
      sleep 1
      yay -Y --gendb
      yay -Syu --devel
      cd "$dotfiles_dir"
      break
      ;;
    [Nn]* | "")
      echo "Skipping yay installation"
      break
      ;;
    *)
      echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
      ;;
    esac
  done
fi

while true; do
  echo "Do you want to install dependencies? [y/N]"
  read install_deps
  case "$install_deps" in
  [Yy]*)
    echo "Installing dependencies"
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install -y git stow unzip nodejs npm zsh
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S git stow unzip nodejs npm zsh
    #  RHEL/Fedora not implemented yet
    # elif [ "$distro" = "RHEL" ]; then
    #   sudo yum install -y git stow unzip nodejs npm zsh
    fi
    echo "Dependencies installed successfully!"
    while true; do
      echo "Set zsh as default shell? [Y/n]"
      read set_default_zsh
      case "$set_default_zsh" in
      [Yy]* | "")
        chsh -s $(which zsh)
        echo "You should log out and back in to see the change!"
        break
        ;;
      [Nn]*)
        echo "Skipping zsh installation"
        break
        ;;
      *)
        echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
        ;;
      esac
    done
    break
    ;;
  [Nn]* | "")
    echo "Skipping dependency installation"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done

while true; do
  echo "Do you want to install packages? [y/N]"
  read install_pkgs
  case "$install_pkgs" in
  [Yy]*)
    echo "Installing packages"
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install -y software-properties-common
      sudo add-apt-repository ppa:neovim-ppa/unstable
      sudo apt update
      sudo apt install -y neovim tmux ranger neofetch
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S neovim tmux ranger neofetch
    #  RHEL/Fedora not implemented yet
    # elif [ "$distro" = "RHEL" ]; then
    #   sudo yum install -y neovim tmux ranger neofetch
    fi
    echo "Packages installed successfully!"
    break
    ;;
  [Nn]* | "")
    echo "Skipping package installation"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done

while true; do
  echo "Do you want to install FiraCode font? [y/N]"
  read install_firacode
  case "$install_firacode" in
  [Yy]*)
    echo "Installing FiraCode"
    if [ "$distro" = "Ubuntu" ]; then
      mkdir -p "$HOME/.local/share/fonts"
      cd "$HOME/.local/share/fonts"
      curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
      unzip FiraCode.zip -d "$HOME/.local/share/fonts"
      rm FiraCode.zip
      fc-cache -fv
    elif [ "$distro" = "Arch" ]; then
      if command -v yay &>/dev/null; then
        yay -S ttf-firacode-nerd
      else
        mkdir -p "$HOME/.local/share/fonts"
        cd "$HOME/.local/share/fonts"
        curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
        unzip FiraCode.zip -d "$HOME/.local/share/fonts"
        rm FiraCode.zip
      fi
      fc-cache -fv
    #  RHEL/Fedora not implemented yet
    # elif [ "$distro" = "RHEL" ]; then
    #   mkdir -p "$HOME/.local/share/fonts"
    #   cd "$HOME/.local/share/fonts"
    #   curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    #   unzip FiraCode.zip -d "$HOME/.local/share/fonts"
    #   rm FiraCode.zip
    #   fc-cache -fv
    fi
    cd "$dotfiles_dir"
    echo "FiraCode font installed successfully!"
    break
    ;;
  [Nn]* | "")
    echo "Skipping FiraCode installation"
    break
    ;;
  *)
    echo "Invalid input. Please enter either \"y\" or \"n\", or leave input blank."
    ;;
  esac
done
