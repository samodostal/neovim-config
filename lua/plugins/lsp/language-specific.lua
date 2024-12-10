return {
	-- Lua (neovim)
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = {
			"Bilal2453/luvit-meta",
		},
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
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
