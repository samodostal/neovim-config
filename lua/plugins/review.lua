return {
	{
		dir = vim.fn.expand "~/Projects/nvim_plugins/review.nvim",
		name = "review.nvim",
		lazy = false,
		keys = {
			{ "<leader>rr", "<cmd>Review<cr>", desc = "Toggle review mode" },
		},
		config = function()
			require("review").setup {}
		end,
	},
}
