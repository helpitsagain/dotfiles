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
        for line in lines:
            if line.startswith('ID='):
                return line.split('=')[1].strip().lower()
        raise Exception('Unable to detect Linux distribution')

def run_command(command):
    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        if 'is up to date -- skipping' in result.stderr: # checks if error indicates package is already up to date
            return True
        print(f'Error: {result.stderr}')
        return False
    return True

def install_yay():
    home_dir = os.path.expanduser('~')
    yay_dir = os.path.join(home_dir, 'yay')
    commands = [
        'sudo pacman -S git base-devel --noconfirm'
        f'git clone https://aur.archlinux.org/yay.git {yay_dir}',
        f'cd {yay_dir} && makepkg -si',
        'yay -Y --gendb --noconfirm',
        'yay -Syu --devel --noconfirm',
    ]
    for cmd in commands:
        if not run_command(cmd):
            return

def install_dependencies(distro: str):
    commands = []
    if distro == 'debian':
        commands.extend([
            'sudo apt update -y && sudo apt upgrade -y',
            'sudo apt install -y git stow unzip nodejs npm python3',
        ])
    elif distro == 'arch':
        commands.extend([
            'sudo pacman -Syu --noconfirm',
            'sudo pacman -S git stow unzip nodejs npm python --noconfirm',
        ])
    commands.append('sudo npm install -g pyright')
    for cmd in commands:
        if not run_command(cmd):
            return

def install_core_packages(distro: str):
    commands = []
    if distro == 'debian':
        commands.append([
            'sudo add-apt-repository -y ppa:neovim-ppa/unstable',
            'sudo apt update -y',
            'sudo apt install -y neovim tmux ranger neofetch',
        ])
    elif distro == 'arch':
        commands.append('sudo pacman -S neovim tmux ranger neofetch --noconfirm')
    for cmd in commands:
        if not run_command(cmd):
            return

# TODO: figure out optional packages
def install_optional_packages(distro: str):
    commands = []
    if distro == 'debian':
        commands.append([
            'sudo apt install -y google-chrome-stable gnome-tweaks',
        ])
    elif distro == 'arch':
        commands.append('yay -S google-chrome gnome-tweaks --noconfirm')
    for cmd in commands:
        if not run_command(cmd):
            return

def stow_files():
    dotfiles_dir = get_dotfiles_dir()
    commands = [
        'rm -rf ~/.bashrc* ~/.bash_aliases* ~/.zshrc* ~/.zshenv* ~/.zsh_aliases*',
        f'cd {dotfiles_dir} && stow .',
        'sudo ln ~/bin/oh-my-posh /usr/bin/'
    ]
    for cmd in commands:
        if not run_command(cmd):
            return

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
    choose_install_core_packages = input('Do you want to install packages? [y/N] ').lower().strip()
    if choose_install_core_packages in ['yes', 'y']:
        print('Installing packages')
        install_core_packages(distro)
        break
    if choose_install_core_packages in ['no', 'n', '']:
        print('Skipping packages')
        break
    print('Invalid input. Please enter either "y" or "n", or leave input blank.')

# while True:
#     choose_install_optional_packages = input('Do you want to install packages? [y/N] ').lower().strip()
#     if choose_install_optional_packages in ['yes', 'y']:
#         print('Installing packages')
#         install_core_packages(distro)
#         break
#     if choose_install_optional_packages in ['no', 'n', '']:
#         print('Skipping packages')
#         break
#     print('Invalid input. Please enter either "y" or "n", or leave input blank.')

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

