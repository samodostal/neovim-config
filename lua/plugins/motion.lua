return {
	{
		"folke/flash.nvim",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function() require("flash").jump() end,
				desc = "Flash motion",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function() require("flash").treesitter() end,
				desc = "Flash treesitter motion",
			},
		},
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			max_join_length = 512,
		},
		keys = {
			{ "<leader>m", "<cmd>TSJToggle<cr>", desc = "TreeSJ toggle" },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kawre/neotab.nvim",
		opts = {
			smart_punctuators = {
				enabled = true,
				semicolon = {
					enabled = true,
				},
			},
		},
	},
	{
		"kylechui/nvim-surround",
		opts = {},
	},
	{
		"johmsalas/text-case.nvim",
		opts = {},
		keys = {
			{ "ga.", "<cmd>TextCaseOpenTelescope<cr>", desc = "Telescope" },
		},
	},
}
