local M = {}

-- ':h lsp-config'
M.lsp_configurations = {
	gdscript = {
		on_exit = require("plugins.lsp.gdscript").on_exit,
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "Snacks" },
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
			"/usr/bin/clangd",
			"--clang-tidy",
		},
	},
}

return M
