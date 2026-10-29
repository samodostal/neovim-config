local gdscript = require "plugins.lsp.gdscript"

return {
	cmd = vim.lsp.rpc.connect(gdscript.host, gdscript.port),
	filetypes = { "gdscript", "gdshader" },
	root_markers = { "project.godot", ".git" },
}
