return {
	"gbprod/yanky.nvim",
	opts = {
		highlight = {
			timer = 200,
		},
	},
	keys = {
		{ "p", "<Plug>(YankyPutAfter)", desc = "Yanky paste after" },
		{ "P", "<Plug>(YankyPutBefore)", desc = "Yanky paste before" },
		{ "<C-f>", "<Plug>(YankyCycleForward)", desc = "Yanky previous entry" },
		{ "<C-g>", "<Plug>(YankyCycleBackward)", desc = "Yanky next entry" },
	},
}
