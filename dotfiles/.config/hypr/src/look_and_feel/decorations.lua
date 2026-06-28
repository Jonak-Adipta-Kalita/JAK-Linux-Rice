hl.config({
	general = {
		gaps_in          = 10,
		gaps_out         = 20,

		border_size      = 2,

		col              = {
			active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,

		allow_tearing    = false,
	},

	decoration = {
		rounding           = 20,
		rounding_power     = 1,

		active_opacity     = 1.0,
		inactive_opacity   = 0.8,
		fullscreen_opacity = 1.0,

		shadow             = {
			enabled      = true,
			range        = 32,
			render_power = 3,
			color        = "rgba(66000000)",
		},

		blur               = {
			enabled           = true,
			size              = 4,
			passes            = 1,
			vibrancy          = 0.1696,
			new_optimizations = true,
			ignore_opacity    = true,
			xray              = false,
			popups            = false,
			input_methods     = false,
		},
	}
})
