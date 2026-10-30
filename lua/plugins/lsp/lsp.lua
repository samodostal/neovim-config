return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		config = function()
			local packages = require "plugins.mason.packages"
			local lsp_configurations = require("plugins.lsp.configurations").lsp_configurations

			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			for server, config in pairs(lsp_configurations) do
				vim.lsp.config(server, config)
			end

			require("mason-lspconfig").setup {
				automatic_enable = {
					exclude = packages.managed_separately,
				},
			}

			require("plugins.lsp.gdscript").setup()

			vim.diagnostic.config {
				signs = false,
				severity_sort = true,
				virtual_text = true,
				float = {
					header = "",
					source = true,
				},
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client then
						client.server_capabilities.documentFormattingProvider = false
					end

					local buf = args.buf

					if not vim.b[buf].lsp_highlight_set then
						vim.b[buf].lsp_highlight_set = true

						vim.api.nvim_create_autocmd("CursorHold", {
							buffer = buf,
							callback = function()
								local row, col = unpack(vim.api.nvim_win_get_cursor(0))
								local last = vim.b[buf].lsp_highlight_pos
								if last and last[1] == row and last[2] == col then
									return
								end
								vim.b[buf].lsp_highlight_pos = { row, col }
								vim.lsp.buf.document_highlight()
							end,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
							buffer = buf,
							callback = function()
								vim.b[buf].lsp_highlight_pos = nil
								vim.lsp.buf.clear_references()
							end,
						})
					end

					if vim.b[buf].lsp_keymaps_set then
						return
					end
					vim.b[buf].lsp_keymaps_set = true

					local k = function(lhs, rhs)
						vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true, noremap = true })
					end

					k("gd", function() require("telescope.builtin").lsp_definitions() end)
					k("gr", function() require("telescope.builtin").lsp_references() end)
					k("gR", function() require("telescope.builtin").grep_string() end)
					k("gD", vim.lsp.buf.declaration)
					k("gi", vim.lsp.buf.implementation)
					k("gy", vim.lsp.buf.type_definition)
					k("<leader>ca", vim.lsp.buf.code_action)
					k("<leader>rn", vim.lsp.buf.rename)
					k("<leader>pd", vim.diagnostic.open_float)
					k("K", vim.lsp.buf.hover)
				end,
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
}
