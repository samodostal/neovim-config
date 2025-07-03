return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
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
			pickers = {
				git_files = {
					recurse_submodules = true,
				},
				find_files = {
					hidden = true,
					-- theme = "cursor",
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
					},
				},
			},
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Telescope find git files" },
			{
				"<leader>fr",
				"<cmd>lua require('plugins.extensions.telescope-multigrep')()<cr>",
				desc = "Telescope ripgrep files",
			},
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Telescope ripgrep word under cursor" },
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
