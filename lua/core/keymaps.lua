local map = require("core.utils").map
local map_menu = require("core.utils").map_menu

map("n", "<leader>", "<nop>")

map("n", "<C-e>", "<C-i>")

map("n", "<C-i>", "<C-u>")
map("n", "<C-d>", "<C-d>")
map("v", "<C-i>", "<C-u>")
map("v", "<C-d>", "<C-d>")

map("n", "<leader>t", ":b#<CR>")

map(
	"n",
	"gch",
	":lua if vim.g.comment_color == '#989db5' then "
		.. "vim.cmd('highlight Comment guifg=#565f89') "
		.. "vim.g.comment_color = '#565f89' else "
		.. "vim.cmd('highlight Comment guifg=#989db5') "
		.. "vim.g.comment_color = '#989db5' end<CR>"
)

map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<c-t>", "<c-\\><c-n>")

map_menu("Neovim management", "<leader>nn", {
	{ text = "Check health", cmd = ":checkhealth" },
	{ text = "Lazy", cmd = ":Lazy" },
	{ text = "Mason", cmd = ":Mason" },
	{ text = "LSP info", cmd = ":LspInfo" },
})

map("n", "<leader>cc", "<cmd>lua require('core.compiler').compile_and_run()<cr>")
