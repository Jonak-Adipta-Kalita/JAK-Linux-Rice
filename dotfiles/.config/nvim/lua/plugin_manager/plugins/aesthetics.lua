return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavor = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent = true
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme "catppuccin"
		end,
	},
	{
		"vim-airline/vim-airline",
	},
	{
		"ryanoasis/vim-devicons",
		priority = 500,
	},
	{
		"preservim/nerdtree",
	},

	{
		"ap/vim-css-color",
	},
	{
		"terryma/vim-multiple-cursors",
		lazy = true,
	},
	{
		'vyfor/cord.nvim',
	},
	{
		"wakatime/vim-wakatime", lazy = false
	}
}
