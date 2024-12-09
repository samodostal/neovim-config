return {
	{
		"Saghen/blink.cmp",
		version = "v0.*",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			sources = {
				completion = {
					enabled_providers = {
						"snippets",
						"lazydev",
						"lsp",
						"path",
						"buffer",
					},
				},
				providers = {
					lsp = { fallback_for = { "lazydev" } },
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
			documentation = {
				auto_show = true,
			},
			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},
			},
			signature = {
				enabled = true,
				trigger = {
					show_on_insert_or_trigger_character = true,
				},
			},
		},
	},
}
