# dotfiles
should work just fine on Arch and Debian based distros. not too sure about Red Hat distros yet.
packages installed: `neovim`, `tmux`,`ranger`, and `neofetch`

## dependencies
proper functioning of these dotfiles require `git`, `stow`, `unzip`, `nodejs`, `npm`

Arch:
```
sudo pacman -S git stow unzip nodejs npm
```

Debian:
```
sudo apt install -y git stow unzip nodejs npm
```

Red Hat:
```
sudo yum install -y git stow unzip nodejs npm
```

## usage
```
git clone https://github.com/helpitsagain/dotfiles
```

```
cd dotfiles
```

```
stow .
```

