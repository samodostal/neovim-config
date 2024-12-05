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
					-- ["core.completion"] = {
					-- 	config = {
							-- engine = "nvim-cmp",
					-- 	},
					-- },
					["core.dirman"] = {},
				},
			}

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
}
