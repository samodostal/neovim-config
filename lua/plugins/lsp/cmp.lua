return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require "cmp"
			local lspkind = require "lspkind"

			cmp.setup {
				sources = {
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
				mapping = {
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
						else
							cmp.complete()
						end
					end, { "i", "c" }),
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
					["<C-j>"] = cmp.mapping(function()
						return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function()
						return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
					end, { "i", "s" }),
				},
				formatting = {
					format = lspkind.cmp_format {
						mode = "symbol_text",
						show_labelDetails = true,
					},
				},
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
			}
		end,
	},
}
