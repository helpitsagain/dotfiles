#!/usr/bin/env python
import os
import subprocess
import platform


def get_dotfiles_dir():
    # shell command to get script's dir
    result = subprocess.run(['dirname', os.path.realpath(__file__)], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # check if command was successful
    if result.returncode == 0: 
        script_dir = result.stdout.strip()
        dotfiles_dir = script_dir[:script_dir.rindex('/')] # cuts off script folder from path
        return dotfiles_dir

    print(f'Error: {result.stderr}')
    return ''

def get_distro():
    info = platform.freedesktop_os_release()
    if 'ID_LIKE' in info:
        return info['ID_LIKE']
    return info['ID']

home_dir: str = os.path.expanduser('~')
dotfiles_dir: str = get_dotfiles_dir()
distro: str = get_distro()

# install yay 
if distro == 'arch':
    while True:
        install_yay = input('Do you want to install yay? [y/N] ').lower().strip()
        if install_yay in ['yes', 'y']:
            os.chdir(home_dir)
            os.system('git clone https://aur.archlinux.org/yay.git')
            os.chdir('yay')
            os.system('makepkg -si')
            os.system('sleep 1')
            os.system('yay -Y --gendb')
            os.system('yay -Syu --devel')
            break

        if install_yay in ['no', 'n', '']:
           print('Skipping yay')
           break
       
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')

# install dependencies 
while True:
    install_deps = input('Do you want to install dependencies? [y/N] ').lower().strip()

    if install_deps in ['yes', 'y']:
        print('Installing dependencies')
        if distro == 'debian':
            os.system('sudo apt install -y git stow unzip nodejs npm')
        elif distro == 'arch':
            os.system('sudo pacman -S git stow unzip nodejs npm')
        elif distro == 'fedora':
            os.system('sudo dnf install -y git stow unzip nodejs npm')
        os.system('sudo npm install -g pyright')
        break

    if install_deps in ['no', 'n', '']:
        print('Skipping dependencies')
        break

    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

# install packages 
while True:
    install_pkgs = input('Do you want to install packages? [y/N] ').lower().strip()

    if install_pkgs in ['yes', 'y']:
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
    
    if install_pkgs in ['no', 'n', '']:
        print('Skipping packages')
        break

    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

while True:
    stow_dotfiles = input('Do you want to run stow right now? [y/N] ').lower().strip()

    if stow_dotfiles in ['yes', 'y']:
        os.system('rm -rf ~/.bashrc ~/.bash_aliases ~/.zshrc ~/.zshenv ~/.zsh_aliases')
        os.chdir(dotfiles_dir)
        os.system('stow .')
        break

    if stow_dotfiles in ['no', 'n', '']:
        print('You can run stow at any time by changing into the dotfiles folder')
        print('and running \'stow .\'')

