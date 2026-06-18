local sources_short = {
	lsp = "[LSP]",
	buffer = "[BUF]",
	path = "[PATH]",
	snippets = "[SNIP]",
	lazydev = "[LAZY]",
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
				default = { "lsp", "snippets", "path", "buffer" },

				providers = {
					lsp = {
						name = "LSP",
						score_offset = 100,
					},

					snippets = {
						name = "Snippets",
						score_offset = 30,
					},

					path = {
						name = "Path",
						score_offset = 10,
					},

					buffer = {
						name = "Buffer",
						score_offset = -15,
						min_keyword_length = 4,
					},

					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 90,
					},
				},
			},
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" },

				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },

				["<C-Space>"] = { "show", "fallback" },
				["<C-e>"] = { "hide", "fallback" },

				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			completion = {
				keyword = { range = "full" },

				trigger = {
					show_on_keyword = true,
					show_on_trigger_character = true,
				},

				accept = {
					auto_brackets = { enabled = true },
				},

				list = {
					selection = {
						preselect = false,
					},

					cycle = {
						from_bottom = false,
					},
				},

				menu = {
					auto_show = true,

					draw = {
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
					auto_show_delay_ms = 150,
					update_delay_ms = 50,
				},
			},
			signature = {
				enabled = true,
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			fuzzy = {
				implementation = "prefer_rust",

				use_frecency = true,
				use_proximity = true,

				sorts = {
					"exact",
					"score",
					"label",
				},
			},
		},
	},
}
