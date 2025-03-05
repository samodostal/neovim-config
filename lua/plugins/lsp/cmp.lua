local sources_short = {
	Snippets = "[SNIP]",
	Lazydev = "[LAZY]",
	LSP = "[LSP]",
	Path = "[PATH]",
	Buffer = "[BUF]",
}

return {
	{
		"Saghen/blink.cmp",
		version = "v0.*",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"xzbdmw/colorful-menu.nvim",
		},
		opts = {
			sources = {
				default = {
					"lazydev",
					"lsp",
					"snippets",
					"path",
					"buffer",
				},
				providers = {
					lsp = { fallbacks = { "lazydev" } },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				},
			},
			keymap = {
				["<C-y>"] = { "select_and_accept" },

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "show", "select_next", "fallback" },

				["<C-d>"] = { "show_documentation", "hide_documentation" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-j>"] = { "snippet_forward", "fallback" },
				["<C-k>"] = { "snippet_backward", "fallback" },
			},
			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},
				menu = {
					-- draw = {
					-- 	columns = {
					-- 		{ "label", "label_description", gap = 1 },
					-- 		{ "kind_icon", gap = 1 },
					-- 		{ "source_name" },
					-- 	},
					-- 	components = {
					-- 		source_name = {
					-- 			text = function(ctx) return sources_short[ctx.source_name] or ctx.source_name end,
					-- 		},
					-- 	},
					-- },
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = {
							{ "kind_icon" },
							{ "label", gap = 1 },
							{ "source_name" },
						},
						components = {
							label = {
								text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							source_name = {
								text = function(ctx) return sources_short[ctx.source_name] or ctx.source_name end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 50,
				},
			},
			signature = {
				enabled = true,
			},
			fuzzy = {
				use_frecency = false,
				use_proximity = false,
			}
		},
	},
}
