local on_attach = function(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.semanticTokensProvider = nil
end

return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		config = function()
			local mason_lspconfig = require "mason-lspconfig"
			local lspconfig = require "lspconfig"

			local packages = require "plugins.mason.packages"
			local lsp_configurations = require("plugins.lsp.configurations").lsp_configurations
			local map = require("core.utils").map

			mason_lspconfig.setup()
			mason_lspconfig.setup_handlers {
				function(server)
					if not vim.tbl_contains(packages.managed_separately, server) then
						local config = lsp_configurations[server] or {}
						config.on_attach = on_attach
						config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)

						lspconfig[server].setup(config)
					end
				end,
			}

			-- Godot is weird
			local config = {
				on_attach = on_attach,
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			}
			lspconfig.gdscript.setup(config)

			vim.diagnostic.config {
				signs = false,
				severity_sort = true,
				virtual_text = true,
				float = {
					header = "",
					source = true,
				},
			}

			map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
			map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
			map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
			map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
			map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
			map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
			map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
			map("n", "<leader>pd", "<cmd>lua vim.diagnostic.open_float()<cr>")
			map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
}
