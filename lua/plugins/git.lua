return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup {
				persist_mode = true,
				float_opts = {
					border = "single",
				},
			}

			local lazygit = require("toggleterm.terminal").Terminal:new {
				cmd = "lazygit",
				direction = "float",
				hidden = true,
			}

			function _lazygit_toggle()
				lazygit:toggle()
			end
		end,
		keys = {
			{ "<leader>gs", "<cmd>lua _lazygit_toggle()<cr>", desc = "Open lazygit with toggleterm.nvim" },
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
