return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			-- Linters installed with Mason, binaries added to $PATH on neovim start
			local linters_with_ft = require("plugins.mason.packages").linters_with_ft
			local utils = require "core.utils"

			require("lint").linters_by_ft = utils.packages_by_ft_with_commands(linters_with_ft)

			vim.api.nvim_create_autocmd({ "BufReadPost", "TextChanged" }, {
				callback = function() require("lint").try_lint() end,
			})
		end,
	},
}
