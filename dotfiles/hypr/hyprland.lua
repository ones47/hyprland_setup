-- hyprland.lua
-- Catppuccin Mocha rice config

hl.monitor({
	output   = "eDP-1",
	mode     = "1920x1080@60",
	position = "0x0",
	scale    = 1.0,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = 1.0,
})

local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local launcher    = "rofi -show drun -show-icons"
local runner      = "rofi -show run"

hl.on("hyprland.start", function()
	hl.exec_cmd("sleep 1 && hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.config({
	general = {
		gaps_in  = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border   = { colors = {"rgba(cba6f7ff)", "rgba(89b4faff)"}, angle = 45 },
			inactive_border = "rgba(313244ff)",
		},
		resize_on_border = false,
		allow_tearing    = false,
		layout           = "dwindle",
	},
	decoration = {
		rounding       = 10,
		rounding_power = 2,
		active_opacity   = 1.0,
		inactive_opacity = 0.95,
		shadow = {
			enabled      = true,
			range        = 4,
			render_power = 3,
			color        = "rgba(1a1a2eff)",
		},
		blur = {
			enabled  = true,
			size     = 6,
			passes   = 2,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",     enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",     enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",    enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "almostLinear", style = "popin 87%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })

hl.config({
	dwindle = { preserve_split = true },
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo   = true,
	},
	input = {
		kb_layout    = "us",
		follow_mouse = 1,
		sensitivity  = 0,
		touchpad = {
			natural_scroll = true,
			tap_to_click   = true,
		},
	},
})

hl.window_rule({
	name  = "kitty-opacity",
	match = { class = "^kitty$" },
	opacity = 0.85,
})

hl.window_rule({
	name  = "suppress-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.layer_rule({
	name  = "blur-waybar",
	match = { namespace = "^waybar$" },
	blur  = true,
})

hl.layer_rule({
	name  = "blur-rofi",
	match = { namespace = "^rofi$" },
	blur  = true,
})

local mainMod = "SUPER"
local secondMod = "SUPER + SHIFT"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd(launcher))
hl.bind(secondMod .. " + Space",  hl.dsp.exec_cmd(runner))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + M", hl.dsp.exit())

hl.bind(secondMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(secondMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true}))
hl.bind(mainMod .. " + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true}))
hl.bind(mainMod .. " + k", hl.dsp.window.resize({ x = 0, y = -20, relative = true}))
hl.bind(mainMod .. " + j", hl.dsp.window.resize({ x = 0, y = 20, relative = true}))

hl.bind(secondMod .. " + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(secondMod .. " + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(secondMod .. " + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(secondMod .. " + j", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copy area"))
