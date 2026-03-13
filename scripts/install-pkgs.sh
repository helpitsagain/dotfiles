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
    deps_ok=1
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install -y git stow unzip nodejs npm zsh fcitx5 fcitx5-config-qt || deps_ok=0
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S git stow unzip nodejs npm zsh fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-xkb --noconfirm || deps_ok=0
    #  RHEL/Fedora not implemented yet
    # elif [ "$distro" = "RHEL" ]; then
    #   sudo yum install -y git stow unzip nodejs npm zsh
    else
      deps_ok=0
      echo "Unsupported distro for dependency installation"
    fi

    if [ "$deps_ok" -ne 1 ]; then
      echo "Dependency installation failed. Skipping input method setup."
      break
    fi

    # Ensure fcitx5 starts automatically on KDE/Plasma sessions.
    if ! mkdir -p "$HOME/.config/autostart"; then
      echo "Failed to create autostart directory"
      break
    fi

    if ! cat >"$HOME/.config/autostart/fcitx5.desktop" <<'EOF'
[Desktop Entry]
Name=Fcitx5
GenericName=Input Method
Comment=Start Input Method
Exec=fcitx5
Icon=fcitx5
Terminal=false
Type=Application
Categories=System;Utility;
X-GNOME-AutoRestart=false
X-GNOME-Autostart-Phase=Applications
X-KDE-autostart-after=panel
EOF
    then
      echo "Failed to create fcitx5 autostart file"
      break
    fi

    echo "Dependencies installed successfully!"
    echo "Log out and back in to apply input method environment variables in Wayland sessions."
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
    pkgs_ok=1
    if [ "$distro" = "Ubuntu" ]; then
      sudo apt install -y software-properties-common || pkgs_ok=0
      sudo add-apt-repository ppa:neovim-ppa/unstable || pkgs_ok=0
      sudo apt update || pkgs_ok=0
      sudo apt install -y neovim tmux ranger neofetch || pkgs_ok=0
    elif [ "$distro" = "Arch" ]; then
      sudo pacman -S neovim tmux ranger neofetch --noconfirm || pkgs_ok=0
    #  RHEL/Fedora not implemented yet
    # elif [ "$distro" = "RHEL" ]; then
    #   sudo yum install -y neovim tmux ranger neofetch
    else
      pkgs_ok=0
      echo "Unsupported distro for package installation"
    fi

    if [ "$pkgs_ok" -ne 1 ]; then
      echo "Package installation failed"
      break
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
