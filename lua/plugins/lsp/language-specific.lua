return {
	-- Lua (neovim)
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- JSON
	{
		"b0o/schemastore.nvim",
		ft = "json",
	},

	-- Java: nvim-jdtls
	-- Haskell: haskell-tools.nvim
	-- Rust: rustaceanvim

	-- TypeScript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				publish_diagnostic_on = "change",
				expose_as_code_action = {
					"add_missing_imports",
					"remove_unused_imports",
					"organize_imports",
				},
				tsserver_plugins = {},
				-- complete_function_calls = true,
				-- include_completions_with_insert_text = true,
			},
		},
	},

	-- C
	-- {
	-- 	"dhananjaylatkar/cscope_maps.nvim",
	-- 	opts = {},
	-- },

	-- Plant UML
	{
		"weirongxu/plantuml-previewer.vim",
		dependencies = {
			{ "tyru/open-browser.vim" },
		},
		lazy = false,
	},
}
