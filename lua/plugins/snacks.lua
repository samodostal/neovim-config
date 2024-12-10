return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			input = { enabled = true },
			indent = {
				enabled = true,
				scope = {
					animate = {
						enabled = false,
					},
				},
			},
		},
		keys = {
			-- Git
			{ "<leader>gs", function() Snacks.lazygit() end, desc = "Lazygit" },
			{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
			{ "<leader>go", function() Snacks.gitbrowse() end, desc = "Git Browse" },
			{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
			{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },

			-- Notifier
			{ "<leader>ns", function() Snacks.notifier.show_history() end, desc = "Show notifier history" },
			{ "<leader>nh", function() Snacks.notifier.hide() end, desc = "Hide notifications" },

			{ "<leader>rf", function() Snacks.rename.rename_file() end, desc = "LSP Rename file" },

			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win {
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
					}
				end,
			},
		},
	},
}
