local ignored_dirs = {
	"__pycache__",
	".cache",
	".direnv",
	".git",
	".godot",
	".hg",
	".history",
	".idea",
	".next",
	".nuxt",
	".svn",
	".turbo",
	".venv",
	".vscode",
	"addons",
	"build",
	"coverage",
	"dist",
	"node_modules",
	"out",
	"target",
	"vendor",
}

local ignored_files = {
	"*.gd.uid",
	"*.import",
	"*.tscn",
	"flake.lock",
	"package-lock.json",
	"yarn.lock",
}

local file_ignore_patterns = {}
local ignore_globs = {}
local utils = require "core.utils"

for _, dir in ipairs(ignored_dirs) do
	local escaped = vim.pesc(dir)
	table.insert(file_ignore_patterns, "^" .. escaped .. "/")
	table.insert(file_ignore_patterns, "/" .. escaped .. "/")
	table.insert(ignore_globs, "--glob=!**/" .. dir .. "/**")
end

for _, file in ipairs(ignored_files) do
	local suffix = vim.pesc(file:gsub("^%*", ""))
	table.insert(file_ignore_patterns, suffix .. "$")
	table.insert(ignore_globs, "--glob=!**/" .. file)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
				},
				file_ignore_patterns = file_ignore_patterns,
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
					file_ignore_patterns = {},
					find_command = function()
						local cmd = { "rg", "--files" }
						vim.list_extend(cmd, utils.dotfiles_rg_args())
						return vim.list_extend(cmd, ignore_globs)
					end,
				},
				live_grep = {
					additional_args = utils.dotfiles_rg_args,
				},
				grep_string = {
					additional_args = utils.dotfiles_rg_args,
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
			{ "<leader>y", "<cmd>Telescope registers<cr>", desc = "Telescope registers" },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function() require("telescope").load_extension "fzf" end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function() require("telescope").load_extension "ui-select" end,
	},
}
