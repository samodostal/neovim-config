local M = {}

-- ':h lspconfig-setup'
M.lsp_configurations = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	clangd = {
		cmd = {
			"/run/current-system/sw/bin/clangd",
		},
	},
}

return M
