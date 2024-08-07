local map = require("core.utils").map
local map_menu = require("core.utils").map_menu

map("n", "<leader>", "<nop>")

map("n", "<leader>t", ":b#<CR>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map_menu("Neovim management", "<leader>nn", {
	{ text = "Check health", cmd = ":checkhealth" },
	{ text = "Lazy", cmd = ":Lazy" },
	{ text = "Mason", cmd = ":Mason" },
	{ text = "LSP info", cmd = ":LspInfo" },
})
