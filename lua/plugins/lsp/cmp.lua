return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require "cmp"

			cmp.setup {
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
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
					["<C-j>"] = cmp.mapping(
						function() return vim.snippet.active { direction = 1 } and vim.snippet.jump(1) end,
						{ "i", "s" }
					),
					["<C-k>"] = cmp.mapping(
						function() return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1) end,
						{ "i", "s" }
					),
				},
				snippet = {
					expand = function(args) vim.snippet.expand(args.body) end,
				},
			}
		end,
	},
}
