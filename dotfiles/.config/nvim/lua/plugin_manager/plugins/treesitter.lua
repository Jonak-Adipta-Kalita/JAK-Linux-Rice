return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python", "javascript", "typescript", "c", "go", "rust", "lua", "vimdoc"
				-- i mean, its better to download it directly when the files are opened ;-;
			},
			sync_install = false,
			auto_install = true,
			indent = {
				enable = true
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
			on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')
				pcall(vim.treesitter.start)
			end
		})
	end
}
