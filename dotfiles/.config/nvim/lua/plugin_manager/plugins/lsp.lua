return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"j-hui/fidget.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})

		require("mason").setup({})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"pylsp",
				"ts_ls",
				"lua_ls",
				"clangd",
				"gopls",
				"rust_analyzer",
				"tailwindcss",
				"svelte",
				"emmet_ls",
				"omnisharp"
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup {
						capabilities = capabilities
					}
				end,
			},
		})

		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					},
					workspaces = {
						library = {}
					}
				}
			}
		}

		lspconfig.rust_analyzer.setup {}

		lspconfig.omnisharp.setup({
			cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
		})

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
		vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end
}
