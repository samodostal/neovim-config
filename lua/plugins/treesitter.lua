return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			highlight = {
				enable = true,
			},
		},
		config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup {
				enable_autocmd = false,
			}

			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
		end,
	},
	{ "windwp/nvim-ts-autotag", opts = {} },
}
