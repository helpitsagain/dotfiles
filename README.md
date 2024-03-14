# dotfiles
should work just fine on Arch and Debian based distros.
packages installed: `neovim`, `tmux`,`ranger`, and `neofetch`

## dependencies
proper functioning of these dotfiles require `git`, `stow`, `unzip`, `nodejs`, `npm`, `python`

Arch:
```
sudo pacman -S git stow unzip nodejs npm python
```

Debian:
```
sudo apt install -y git stow unzip nodejs npm python3
```

## usage
```
git clone https://github.com/helpitsagain/dotfiles
```

```
cd dotfiles
```

### if you already have all packages installed and just want the dotfiles:
```
stow .
```

### if you want to run the installation script, which will prompt you to install all dependencies and relevant packages:
#### Debian:
```
python3 scripts/install.py
```

#### Arch: 
```
python scripts/install.py
```
