return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.esupports.indent"] = {},
					["core.esupports.hop"] = {
						config = {
							external_filetypes = { "pdf" },
						},
					},
					["core.dirman"] = {},
					["core.integrations.treesitter"] = {
						config = {
							warn_missing_parsers = false,
						},
					},
				},
			}

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
}
