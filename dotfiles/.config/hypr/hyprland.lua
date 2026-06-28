require("src.monitors")

require("src.autostarts")

require("src.systems.environments")
require("src.systems.permissions")

require("src.look_and_feel.decorations")
require("src.look_and_feel.animations")

require("src.look_and_feel.layouts")

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

require("src.binds")

require("src.inputs")

require("src.systems.window_rules")
