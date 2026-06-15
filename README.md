# Hyprland Setup

A complete Hyprland rice on Arch Linux using Catppuccin Mocha theme.

## System
- **WM:** Hyprland 0.55.2 (Lua config)
- **Theme:** Catppuccin Mocha
- **Font:** JetBrainsMono Nerd Font

## Components
- Hyprland
- Waybar
- Hyprpaper
- Kitty
- Rofi
- Dunst (planned)
- SDDM (planned)

## Installing Hyprland
```bash
sudo pacman -S hyprland kitty waybar dunst xdg-desktop-hyprland qt5-wayland qt6-wayland polkit-kde-agent
```
### Important: Lua Config (Hyprland 0.55+)

Since Hyprland 0.55, configuration moved from `hyprland.conf` (hyprlang syntax) to `hyprland.lua`. If `hyprland.conf` exists, Hyprland loads it instead of the Lua file and regenerates a broken stub on every reload.

Prevent this by making the conf file read-only and empty:

```bash
rm -f ~/.config/hypr/hyprland.conf
touch ~/.config/hypr/hyprland.conf
chmod 444 ~/.config/hypr/hyprland.conf
```

This makes Hyprland fall through to `hyprland.lua` instead.

### Autostart on TTY login

Hyprland must be launched via `start-hyprland`, not `Hyprland` directly. Add to `~/.zprofile`:

```bash
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec start-hyprland
fi
```

### Config

The full Hyprland config is at [`dotfiles/hypr/hyprland.lua`](dotfiles/hypr/hyprland.lua).

Copy it to `~/.config/hypr/hyprland.lua`.

## Zsh Setup

Switch shell from bash to zsh:

```bash
sudo pacman -S zsh
chsh -s /bin/zsh
```

The config includes a Catppuccin-themed two-line prompt, history settings, case-insensitive tab completion (bidirectional, so `adm` matches `ADMIN`), and useful aliases.

The full config is at [`dotfiles/zsh/.zshrc`](dotfiles/zsh/.zshrc).

Copy it to `~/.zshrc`:

```bash
cp dotfiles/zsh/.zshrc ~/.zshrc
source ~/.zshrc
```

## Kitty Terminal

```bash
sudo pacman -S kitty ttf-jetbrains-mono-nerd
```

Kitty config sets Catppuccin Mocha colours, JetBrainsMono Nerd Font, transparency (0.85 opacity), and a powerline-style tab bar.

The full config is at [`dotfiles/kitty/kitty.conf`](dotfiles/kitty/kitty.conf).

Copy it to `~/.config/kitty/kitty.conf`:

```bash
mkdir -p ~/.config/kitty
cp dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
```
