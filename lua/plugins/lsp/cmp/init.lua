local source_icons = {
	lsp = "",
	buffer = "󰈔",
	path = "󰉋",
	snippets = "󰅩",
}

local keymap = {
	["<CR>"] = { "select_and_accept", "fallback" },
	["<C-n>"] = { "show", "select_next", "fallback" },
	["<C-p>"] = { "show", "select_prev", "fallback" },
	["<C-Space>"] = { "show", "fallback" },
	["<C-e>"] = { "hide", "fallback" },
	["<C-d>"] = { "scroll_documentation_down", "fallback" },
	["<C-u>"] = { "scroll_documentation_up", "fallback" },
	["<Tab>"] = { "snippet_forward", "fallback" },
	["<S-Tab>"] = { "snippet_backward", "fallback" },
}

local documentation = {
	auto_show = true,
	auto_show_delay_ms = 150,
	update_delay_ms = 50,
	window = {
		border = "none",
	},
}

local godot = require "plugins.lsp.cmp.godot"

return {
	{
		"Saghen/blink.cmp",
		version = "v1.*",
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
						async = true,
						timeout_ms = 5000,
						transform_items = godot.prepare_items,
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
				},
			},
			keymap = keymap,
			completion = {
				keyword = { range = "full" },

				trigger = {
					show_on_keyword = true,
					show_on_trigger_character = true,
					show_on_backspace = true,
					show_on_backspace_in_keyword = true,
					prefetch_on_insert = false,
				},

				accept = {
					auto_brackets = { enabled = true },
				},

				list = {
					max_items = 500,

					selection = {
						preselect = true,
						auto_insert = false,
					},

					cycle = {
						from_bottom = true,
						from_top = true,
					},
				},

				menu = {
					auto_show = true,
					auto_show_delay_ms = 50,
					border = "none",

					draw = {
						snippet_indicator = "~",
						align_to = "label",
						padding = { 1, 1 },

						columns = {
							{ "kind_icon" },
							{ "label", gap = 2 },
							{ "source_name" },
						},

						components = {
							label = {
								text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
								highlight = godot.label_highlight,
							},

							source_name = {
								ellipsis = false,
								width = { max = 2 },
								text = function(ctx) return source_icons[ctx.source_id] or ctx.source_name end,
							},
						},
					},
				},
				documentation = documentation,
			},
			signature = {
				enabled = true,
				window = {
					border = "none",
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			fuzzy = {
				implementation = "prefer_rust",

				frecency = {
					enabled = true,
				},
				use_proximity = true,

				sorts = {
					"exact",
					"score",
					"sort_text",
					"label",
				},
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)
			godot.setup()
		end,
	},
}
