#!/usr/bin/env python
import os
import subprocess

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
    with open('/etc/os-release', 'r') as f:
        lines = f.readlines()
        for line in lines:
            if line.startswith('ID_LIKE='):
                return line.split('=')[1].strip().lower()
            if line.startswith('ID='):
                return line.split('=')[1].strip().lower()
        raise Exception('Unable to detect Linux distribution')   

def install_yay():
    home_dir = os.path.expanduser('~')
    os.chdir(home_dir)
    os.system('git clone https://aur.archlinux.org/yay.git')
    os.chdir('yay')
    os.system('makepkg -si')
    os.system('sleep 1')
    os.system('yay -Y --gendb')
    os.system('yay -Syu --devel')

def install_dependencies(distro: str):
    if distro == 'debian':
        os.system('sudo apt install -y git stow unzip nodejs npm')
    elif distro == 'arch':
        os.system('sudo pacman -S git stow unzip nodejs npm')
    os.system('sudo npm install -g pyright')

def install_packages(distro: str):
    if distro == 'debian':
        os.system('sudo add-apt-repository ppa:neovim-ppa/unstable')
        os.system('sudo apt update')
        os.system('sudo apt install -y neovim tmux ranger neofetch')
    elif distro == 'arch':
        os.system('sudo pacman -S neovim tmux ranger neofetch')

def stow_files():
    dotfiles_dir = get_dotfiles_dir()
    os.system('rm -rf ~/.bashrc ~/.bash_aliases ~/.zshrc ~/.zshenv ~/.zsh_aliases')
    os.chdir(dotfiles_dir)
    os.system('stow .')

distro = get_distro()

if distro == 'arch':
    while True:
        choose_install_yay = input('Do you want to install yay? [y/N] ').lower().strip()
        if choose_install_yay in ['yes', 'y']:
            install_yay()
            break
        if choose_install_yay in ['no', 'n', '']:
           print('Skipping yay')
           break
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')

while True:
    choose_install_dependencies = input('Do you want to install dependencies? [y/N] ').lower().strip()
    if choose_install_dependencies in ['yes', 'y']:
        print('Installing dependencies')
        install_dependencies(distro)
        break
    if choose_install_dependencies in ['no', 'n', '']:
        print('Skipping dependencies')
        break
    print('Invalid input. Please enter either "y" or "n", or leave input blank.')


while True:
    choose_install_packages = input('Do you want to install packages? [y/N] ').lower().strip()
    if choose_install_packages in ['yes', 'y']:
        print('Installing packages')
        install_packages(distro)
        break
    if choose_install_packages in ['no', 'n', '']:
        print('Skipping packages')
        break
    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

while True:
    choose_run_stow = input('Do you want to run stow right now? [y/N] ').lower().strip()
    if choose_run_stow in ['yes', 'y']:
        print('Stowing files')
        stow_files()
        break
    if choose_run_stow in ['no', 'n', '']:
        print('You can run stow at any time by changing into the dotfiles folder')
        print('and running \'stow .\'')
        break
    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

