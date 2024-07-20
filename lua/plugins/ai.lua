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
}
