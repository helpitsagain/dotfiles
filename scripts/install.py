#!/usr/bin/env python
import os
import platform

def get_distro():
    info = platform.freedesktop_os_release()
    if 'ID_LIKE' in info:
        return info['ID_LIKE']
    return info['ID']

home_dir: str = os.path.expanduser('~')
distro: str = get_distro()

# install yay 
if distro == 'arch':
    while True:
        install_yay = input('Do you want to install yay? [y/N] ').capitalize().strip()
        if install_yay == 'Y':
            os.chdir(home_dir)
            os.system('git clone https://aur.archlinux.org/yay.git')
            os.chdir('yay')
            os.system('makepkg -si')
            os.system('sleep 1')
            os.system('yay -Y --gendb')
            os.system('yay -Syu --devel')
            break

        if install_yay == 'N' or install_yay == '':
           print('Skipping yay')
           break
       
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')

# install dependencies 
while True:
    install_deps = input('Do you want to install dependencies? [y/N] ').capitalize().strip()

    if install_deps == 'Y':
        print('Installing dependencies')
        if distro == 'debian':
            os.system('sudo apt install -y git stow unzip nodejs npm')
        elif distro == 'arch':
            os.system('sudo pacman -S git stow unzip nodejs npm')
        elif distro == 'fedora':
            os.system('sudo dnf install -y git stow unzip nodejs npm')
        break

    if install_deps == 'N' or install_deps == '':
        print('Skipping dependencies')
        break

    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

# install packages 
while True:
    install_pkgs = input('Do you want to install packages? [y/N]').capitalize().strip()

    if install_pkgs == 'Y':
        print('Installing packages')

        if distro == 'debian':
            os.system('sudo add-apt-repository ppa:neovim-ppa/unstable')
            os.system('sudo apt update')
            os.system('sudo apt install -y neovim tmux ranger neofetch')
        elif distro == 'arch':
            os.system('sudo pacman -S neovim tmux ranger neofetch')
        elif distro == 'fedora':
            os.system('sudo dnf install -y neovim tmux ranger neofetch')
        break
    
    if install_pkgs == 'N' or install_pkgs == '':
        print('Skipping packages')
        break

    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

