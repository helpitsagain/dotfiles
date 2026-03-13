# dotfiles
should work just fine on Arch and Debian based distros. not too sure about Red Hat distros yet.
packages installed: `neovim`, `tmux`,`ranger`, and `neofetch`

input method support for Wayland (GTK/Qt dead keys and cedilla) is automated with `fcitx5`.

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

## input method automation (Wayland)
the repository already ships these files through stow:

- `.XCompose`
- `.config/environment.d/input-method.conf`
- `.config/code-flags.conf` (forces VS Code via XWayland)

both installers (`scripts/install-pkgs.sh` and `scripts/install.py`) also:

- install `fcitx5` packages on Arch and Debian/Ubuntu-based distros
- create `~/.config/autostart/fcitx5.desktop` for automatic startup on KDE/Plasma

after running the installer, log out and back in so Wayland picks up environment variables from `~/.config/environment.d/`.

quick test:

- Qt app (Konsole/Kate): `' + c` should produce `ç`
- GTK app (Chrome/VS Code/Discord): `' + c` should also produce `ç`

