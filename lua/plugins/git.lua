return {
	-- Lazygit added via snacks.nvim (snacks.lua)
	-- Oil git extension (oil.lua)
	{
		"FabijanZulj/blame.nvim",
		cmd = "BlameToggle",
		keys = {
			{ "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Toggle Git Blame" },
		},
		opts = {
			focus_blame = false,
			date_format = "%d.%m.%Y",
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
