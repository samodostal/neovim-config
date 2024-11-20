return {
	-- Lazygit added via snacks.nvim (snacks.lua)
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
