return {
	{
		"danymat/neogen",
		opts = {
			enabled = true,
		},
		keys = {
			{ "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc = "Neogen generate" },
		},
	},
}
