local M = {}

local reconnect_attempts = 0

local function schedule_gdscript_reconnect()
	if vim.v.exiting ~= vim.NIL then
		return
	end
	if reconnect_attempts >= 60 then
		return
	end
	reconnect_attempts = reconnect_attempts + 1

	vim.defer_fn(function()
		if next(vim.lsp.get_clients { name = "gdscript" }) ~= nil then
			reconnect_attempts = 0
			return
		end
		vim.lsp.enable "gdscript"
	end, 2000)
end

-- ':h lsp-config'
M.lsp_configurations = {
	gdscript = {
		on_exit = schedule_gdscript_reconnect,
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
