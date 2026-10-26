local function is_hidden_predicate(name, _)
	local hidden_patterns = { "%.uid$", "%.gdshader$", "%.import$" }
	for _, pattern in ipairs(hidden_patterns) do
		if name:match(pattern) then
			return true
		end
	end
	return false
end

return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			custom_oil_winbar = function()
				local path = vim.fn.expand "%"
				path = path:gsub("oil://", "")

				return "  " .. vim.fn.fnamemodify(path, ":.")
			end

			require("oil").setup {
				default_file_explorer = true,
				view_options = {
					show_hidden = false,
					is_hidden_file = is_hidden_predicate,
				},
				win_options = {
					winbar = "%{v:lua.custom_oil_winbar()}",
				},
				use_default_keymaps = false,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-s>"] = { "actions.select", opts = { horizontal = true } },
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

	{
		"malewicz1337/oil-git.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {
			show_file_highlights = false,
			show_directory_highlights = false,
		},
	},
}
