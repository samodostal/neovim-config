return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					local colors = require("tokyonight.colors").setup()

					vim.api.nvim_set_hl(0, "Whitespace", { fg = "#282f47" })
					vim.api.nvim_set_hl(0, "NonText", { fg = "#3d4563" })
					vim.api.nvim_set_hl(0, "FlashMatch", { fg = colors.yellow })
					vim.api.nvim_set_hl(0, "FlashCurrent", { fg = colors.yellow })
					vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#00FFFF" })
				end,
			})

			vim.cmd [[ colorscheme tokyonight-night ]]
		end,
	},
	{
		"tzachar/local-highlight.nvim",
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},
}
