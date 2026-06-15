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

## Waybar

```bash
sudo pacman -S waybar
```

### Module Dependencies

Each right-side module calls an external tool on click/scroll. Install these:

```bash
yay -S wifitui bluetui
sudo pacman -S brightnessctl htop btop pipewire-pulse wireplumber
```

| Module | Tool | Purpose |
|---|---|---|
| `network` | `wifitui` | TUI WiFi manager, opens on click |
| `bluetooth` | `bluetui` | TUI Bluetooth manager, opens on click |
| `backlight` | `brightnessctl` | Scroll to adjust screen brightness |
| `cpu` | `htop` | Opens on click for process view |
| `memory` | `btop` | Opens on click for resource monitor |
| `pulseaudio` + volume buttons | `wpctl` (WirePlumber) | Volume control |
| `custom/power` | `~/.config/rofi/scripts/powermenu.sh` | Power menu |
| `temperature` | `thermal-zone 5` (`x86_pkg_temp`) | CPU package temperature — zone number may differ per machine, check with: `grep -r x86_pkg_temp /sys/class/thermal/thermal_zone*/type` |

### Layout

- **Left:** workspaces — numbered circles, golden when active, only shown if a window exists (or it's the active workspace)
- **Center:** clock — day, date, time
- **Right:** network, bluetooth, backlight, volume controls, battery, cpu, memory, temperature, power button

### Auto-reload on save

```bash
cp scripts/auto-reload.sh ~/
chmod +x ~/auto-reload.sh
~/auto-reload.sh &
```

This watches `~/.config/waybar/` and restarts waybar automatically when config or style files are saved.

### Config

- [`dotfiles/waybar/config.jsonc`](dotfiles/waybar/config.jsonc)
- [`dotfiles/waybar/style.css`](dotfiles/waybar/style.css)

```bash
mkdir -p ~/.config/waybar
cp dotfiles/waybar/config.jsonc ~/.config/waybar/
cp dotfiles/waybar/style.css ~/.config/waybar/
```

## Rofi

```bash
sudo pacman -S rofi-wayland
```

### Theme

Using `rounded-red-dark.rasi` from [adi1090x/rofi-themes-collection](https://github.com/adi1090x/rofi-themes-collection).

```bash
git clone https://github.com/adi1090x/rofi-themes-collection.git ~/rofi-themes-collection
mkdir -p ~/.local/share/rofi/themes
cp ~/rofi-themes-collection/themes/rounded-red-dark.rasi ~/.local/share/rofi/themes/
```

### Config

```bash
mkdir -p ~/.config/rofi
cp dotfiles/rofi/config.rasi ~/.config/rofi/
```

[`dotfiles/rofi/config.rasi`](dotfiles/rofi/config.rasi) just points to the theme:

### Power Menu Script

[`scripts/powermenu.sh`](scripts/powermenu.sh) provides a rofi-based power menu with shutdown, reboot, and logout (suspend and lock are placeholders for later, once hyprlock is configured).

```bash
mkdir -p ~/.config/rofi/scripts
cp scripts/powermenu.sh ~/.config/rofi/scripts/
chmod +x ~/.config/rofi/scripts/powermenu.sh
```

Triggered from the waybar power button (`custom/power` module).

### Launcher Keybinds

In `hyprland.lua`:

```lua
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(secondMod .. " + Space", hl.dsp.exec_cmd("rofi -show run"))
```

`SUPER+Space` opens the app launcher (drun), `SUPER+SHIFT+Space` opens the command runner (run).

## Wallpaper (hyprpaper)

```bash
sudo pacman -S hyprpaper
```

### Config

`hyprpaper.conf` uses absolute paths — `~` is not expanded by hyprpaper.

[`dotfiles/hypr/hyprpaper.conf`](dotfiles/hypr/hyprpaper.conf):

```ini
preload = /home/onesmus/.config/wallpapers/wallpaper.jpg
splash = false

wallpaper {
    monitor = eDP-1
    path = /home/onesmus/.config/wallpapers/wallpaper.jpg
    fit_mode = cover
}
```

The wallpaper image is included at [`dotfiles/wallpapers/wallpaper.jpg`](dotfiles/wallpapers/wallpaper.jpg).

```bash
mkdir -p ~/.config/wallpapers ~/.config/hypr
cp dotfiles/wallpapers/wallpaper.jpg ~/.config/wallpapers/
cp dotfiles/hypr/hyprpaper.conf ~/.config/hypr/
```

If using a different username, update the paths in `hyprpaper.conf` accordingly.

hyprpaper is launched via `exec-once` in `hyprland.lua`:

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1 && hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
end)
```

The `sleep 1` gives the compositor time to initialize before hyprpaper attaches to the monitor.

## File Manager (yazi)

```bash
sudo pacman -S yazi
```

TUI file manager with image preview support, bound in `hyprland.lua`:

```lua
local fileManager = "kitty -e yazi"
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
```

`SUPER+E` opens yazi in a kitty window.
