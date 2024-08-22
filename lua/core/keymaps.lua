local map = require("core.utils").map
local map_menu = require("core.utils").map_menu

map("n", "<leader>", "<nop>")

map("n", "<leader>t", ":b#<CR>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map_menu("Neovim management", "<leader>nn", {
	{ text = "Check health", cmd = ":checkhealth" },
	{ text = "Lazy", cmd = ":Lazy" },
	{ text = "Mason", cmd = ":Mason" },
	{ text = "LSP info", cmd = ":LspInfo" },
})
