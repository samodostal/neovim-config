return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gs", "<cmd>LazyGit<cr>", desc = "LazyGit open" },
			{ "<leader>gc", "<cmd>LazyGitFilter<cr>", desc = "LazyGit filter" },
			{ "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit filter current file" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-", show_count = true },
				topdelete = { text = "-", show_count = true },
				untracked = { text = "" },
			},
			signs_staged_enable = false,
		},
	},
}
