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
	{ "b0o/schemastore.nvim" },

	-- Java: nvim-jdtls
	-- Haskell: haskell-tools.nvim
	-- Rust: rustaceanvim
	-- Typescript: typescript-tools.nvim
}
