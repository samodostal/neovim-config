return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			settings = {
				advanced = {
					inlineSuggestCount = 3,
				},
			},
			suggestion = {
				keymap = {
					accept = "<C-r>",
					next = "<C-c>",
				},
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		branch = "main",
		build = "make tiktoken",
		opts = {
			question_header = "  User  ",
			answer_header = "  Copilot  ",
			error_header = "  Error  ",
			show_folds = false,
		},
		keys = {
			{ "<leader>gc", "<cmd>CopilotChat<cr>", mode = { "n", "v" } },
		},
	},
}
