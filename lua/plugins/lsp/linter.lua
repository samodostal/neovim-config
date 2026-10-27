return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			-- Linters installed with Mason, binaries added to $PATH on neovim start
			local lint = require "lint"
			local linters_with_ft = require("plugins.mason.packages").linters_with_ft
			local utils = require "core.utils"

			lint.linters_by_ft = utils.packages_by_ft_with_commands(linters_with_ft)
			-- lint.linters_by_ft.gdscript = { "gdlint" }

			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function() lint.try_lint() end,
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					if vim.bo.filetype == "gdscript" then lint.try_lint() end
				end,
			})

			vim.api.nvim_create_autocmd("TextChanged", {
				callback = function()
					if vim.bo.filetype ~= "gdscript" then lint.try_lint() end
				end,
			})
		end,
	},
}
