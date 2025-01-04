return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local packages = require "plugins.mason.packages"
			local utils = require "core.utils"

			local packages_linters = {}
			for _, ft_with_linters in pairs(utils.packages_by_ft_with_toolkits(packages.linters_with_ft)) do
				for _, package in ipairs(ft_with_linters) do
					table.insert(packages_linters, package)
				end
			end

			local packages_formatters = {}
			for _, ft_with_formatters in pairs(utils.packages_by_ft_with_toolkits(packages.formatters_with_ft)) do
				for _, package in ipairs(ft_with_formatters) do
					-- Conform.nvim names some packages with '_' instead of correctly using '-'. :/
					local package_parsed = package:gsub("_", "-")
					table.insert(packages_formatters, package_parsed)
				end
			end

			require("mason-tool-installer").setup {
				ensure_installed = utils.merge_tables(
					packages.lsp,
					packages.dap,
					packages_linters,
					packages_formatters
				),
			}
		end,
	},
}
