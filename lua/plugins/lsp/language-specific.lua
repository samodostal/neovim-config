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
	-- Typescript: typescript-tools.nvim

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
