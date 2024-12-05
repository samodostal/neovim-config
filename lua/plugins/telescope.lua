return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					vertical = {
						mirror = true,
					},
					prompt_position = "top",
				},
				file_ignore_patterns = {
					"dist/.*",
					"node_modules/.*",
					"%.git/.*",
					"%.vim/.*",
					"%.idea/.*",
					"%.vscode/.*",
					"%.history/.*",
					"flake.lock",
				},
				mappings = {
					i = {
						["<C-a>"] = require("telescope.actions").select_all,
						["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
						["<esc>"] = require("telescope.actions").close,
					},
				},
			},
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Telescope find git files" },
			{ "<leader>fr", "<cmd>Telescope live_grep<cr>", desc = "Telescope ripgrep files" },
			{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Telescope grep string on files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope ripgrep help files" },
			{ "<leader>fc", "<cmd>Telescope resume<cr>", desc = "Telescope previous picker" },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function() require("telescope").load_extension "fzf" end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
