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
*Full documentation in progress.*
