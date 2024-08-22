return {
	{
		"stevearc/overseer.nvim",
		opts = {
			task_list = {
				max_height = 0.6,
				min_height = 0.6
			},
		},
		keys = {
			{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run" },
			{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer toggle" },
		},
	},
}
