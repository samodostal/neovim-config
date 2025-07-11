local is_hidden_predicate = function(name, _) return name:match "%.uid$" or name:match "%.gdshader$" end

return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup {
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
					is_hidden_file = is_hidden_predicate,
				},
				use_default_keymaps = false,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.refresh",
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
				},
			}

			local map = require("core.utils").map

			map("n", "-", "<cmd>Oil<cr>")
		end,
	},
}
