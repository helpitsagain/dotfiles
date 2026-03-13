#!/usr/bin/env python
import os
import shutil
import subprocess


def get_dotfiles_dir() -> str:
    return os.path.dirname(os.path.dirname(os.path.realpath(__file__)))


def detect_distro() -> str:
    if shutil.which("apt"):
        return "Ubuntu"
    if shutil.which("pacman"):
        return "Arch"
    if shutil.which("dnf"):
        return "Fedora"
    if shutil.which("yum"):
        return "RHEL"
    return "Unknown"


def run_command(command: str) -> bool:
    result = subprocess.run(command, shell=True, text=True)
    return result.returncode == 0


def install_yay(dotfiles_dir: str) -> bool:
    home_dir = os.path.expanduser("~")
    commands = [
        "cd \"$HOME\"",
        "sudo pacman -S --needed git base-devel",
        "git clone https://aur.archlinux.org/yay.git \"$HOME/yay\"",
        "cd \"$HOME/yay\" && makepkg -si",
        "sleep 1",
        "yay -Y --gendb",
        "yay -Syu --devel",
        f"cd \"{dotfiles_dir}\"",
    ]
    for cmd in commands:
        if not run_command(cmd):
            return False
    return True


def install_dependencies(distro: str) -> bool:
    if distro == "Ubuntu":
        return run_command(
            "sudo apt install -y git stow unzip nodejs npm zsh fcitx5 fcitx5-config-qt"
        )
    if distro == "Arch":
        return run_command(
            "sudo pacman -S git stow unzip nodejs npm zsh fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-xkb --noconfirm"
        )
    print("Unsupported distro for dependency installation")
    return False


def setup_fcitx5_autostart() -> bool:
    autostart_dir = os.path.expanduser("~/.config/autostart")
    try:
        os.makedirs(autostart_dir, exist_ok=True)
    except OSError:
        print("Failed to create autostart directory")
        return False

    desktop_content = """[Desktop Entry]
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
"""

    desktop_file = os.path.join(autostart_dir, "fcitx5.desktop")
    try:
        with open(desktop_file, "w", encoding="utf-8") as f:
            f.write(desktop_content)
    except OSError:
        print("Failed to create fcitx5 autostart file")
        return False

    return True


def maybe_set_default_zsh() -> None:
    while True:
        answer = input("Set zsh as default shell? [Y/n] ").lower().strip()
        if answer in ["yes", "y", ""]:
            if run_command("chsh -s $(which zsh)"):
                print("You should log out and back in to see the change!")
            else:
                print("Failed to set zsh as default shell")
            return
        if answer in ["no", "n"]:
            print("Skipping zsh installation")
            return
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')


def install_packages(distro: str) -> bool:
    if distro == "Ubuntu":
        ok = True
        ok = run_command("sudo apt install -y software-properties-common") and ok
        ok = run_command("sudo add-apt-repository ppa:neovim-ppa/unstable") and ok
        ok = run_command("sudo apt update") and ok
        ok = run_command("sudo apt install -y neovim tmux ranger neofetch") and ok
        return ok
    if distro == "Arch":
        return run_command("sudo pacman -S neovim tmux ranger neofetch --noconfirm")

    print("Unsupported distro for package installation")
    return False


def install_firacode(distro: str, dotfiles_dir: str) -> bool:
    if distro == "Ubuntu":
        commands = [
            "mkdir -p \"$HOME/.local/share/fonts\"",
            "cd \"$HOME/.local/share/fonts\"",
            "curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip",
            "unzip FiraCode.zip -d \"$HOME/.local/share/fonts\"",
            "rm FiraCode.zip",
            "fc-cache -fv",
        ]
    elif distro == "Arch":
        if shutil.which("yay"):
            commands = [
                "yay -S ttf-firacode-nerd",
                "fc-cache -fv",
            ]
        else:
            commands = [
                "mkdir -p \"$HOME/.local/share/fonts\"",
                "cd \"$HOME/.local/share/fonts\"",
                "curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip",
                "unzip FiraCode.zip -d \"$HOME/.local/share/fonts\"",
                "rm FiraCode.zip",
                "fc-cache -fv",
            ]
    else:
        return False

    for cmd in commands:
        if not run_command(cmd):
            return False

    return run_command(f'cd "{dotfiles_dir}"')


def main() -> None:
    dotfiles_dir = get_dotfiles_dir()
    distro = detect_distro()

    if distro == "Arch":
        while True:
            answer = input("Do you want to install yay? [y/N] ").lower().strip()
            if answer in ["yes", "y"]:
                if not install_yay(dotfiles_dir):
                    print("yay installation failed")
                break
            if answer in ["no", "n", ""]:
                print("Skipping yay installation")
                break
            print('Invalid input. Please enter either "y" or "n", or leave input blank.')

    while True:
        answer = input("Do you want to install dependencies? [y/N] ").lower().strip()
        if answer in ["yes", "y"]:
            print("Installing dependencies")
            if not install_dependencies(distro):
                print("Dependency installation failed. Skipping input method setup.")
                break
            if not setup_fcitx5_autostart():
                break
            print("Dependencies installed successfully!")
            print(
                "Log out and back in to apply input method environment variables in Wayland sessions."
            )
            maybe_set_default_zsh()
            break
        if answer in ["no", "n", ""]:
            print("Skipping dependency installation")
            break
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')

    while True:
        answer = input("Do you want to install packages? [y/N] ").lower().strip()
        if answer in ["yes", "y"]:
            print("Installing packages")
            if install_packages(distro):
                print("Packages installed successfully!")
            else:
                print("Package installation failed")
            break
        if answer in ["no", "n", ""]:
            print("Skipping package installation")
            break
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')

    while True:
        answer = input("Do you want to install FiraCode font? [y/N] ").lower().strip()
        if answer in ["yes", "y"]:
            print("Installing FiraCode")
            if install_firacode(distro, dotfiles_dir):
                print("FiraCode font installed successfully!")
            else:
                print("Failed to install FiraCode")
            break
        if answer in ["no", "n", ""]:
            print("Skipping FiraCode installation")
            break
        print('Invalid input. Please enter either "y" or "n", or leave input blank.')


if __name__ == "__main__":
    main()
