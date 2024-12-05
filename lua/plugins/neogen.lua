return {
	{
		"danymat/neogen",
		-- opts = {
		-- 	snippet_engine = "luasnip",
		-- },
		keys = {
			{ "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc = "Neogen generate" },
		},
	},
}
