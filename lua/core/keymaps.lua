local map = require("core.utils").map
local map_menu = require("core.utils").map_menu

map("n", "<leader>", "<nop>")

map("n", "<C-e>", "<C-i>")

map("n", "<C-i>", "<C-u>")
map("n", "<C-d>", "<C-d>")
map("v", "<C-i>", "<C-u>")
map("v", "<C-d>", "<C-d>")

map("n", "<leader>t", ":tabnext<cr>")

map(
	"n",
	"gch",
	"<cmd>lua if vim.g.comment_color == '#928374' then "
		.. "vim.cmd('highlight Comment guifg=#665c54') "
		.. "vim.g.comment_color = '#665c54' else "
		.. "vim.cmd('highlight Comment guifg=#928374') "
		.. "vim.g.comment_color = '#928374' end<cr>"
)

map("n", "gm", "mA")
map("n", "gb", "'A")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "ycc", "yygccp", { noremap = false })

map("t", "<c-t>", "<c-\\><c-n>")

map_menu("Neovim management", "<leader>nn", {
	{ text = "Check health", cmd = "<cmd>checkhealth" },
	{ text = "Lazy", cmd = "<cmd>Lazy" },
	{ text = "Mason", cmd = "<cmd>Mason" },
	{ text = "LSP info", cmd = "<cmd>LspInfo" },
})

map("n", "<leader>cc", "<cmd>lua require('core.compiler').compile_and_run(1)<cr>")
map("n", "<leader>cf", "<cmd>lua require('core.compiler').compile_and_run(2)<cr>")

map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<cr>")
map("n", "gN", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

vim.keymap.set("n", "<leader>uu", function()
	if vim.fn.exists ":Undotree" == 0 then
		vim.cmd.packadd "nvim.undotree"
	end
	vim.cmd.Undotree()
end, { desc = "Undo tree" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nvim-undotree",
	callback = function(args)
		local function close() vim.cmd.Undotree() end
		vim.keymap.set("n", "q", close, { buffer = args.buf, silent = true, desc = "Close undo tree" })
		vim.keymap.set("n", "<Esc>", close, { buffer = args.buf, silent = true })
		vim.keymap.set("n", "<CR>", close, { buffer = args.buf, silent = true })
		vim.keymap.set("n", "g?", "<cmd>help package-undotree<cr>", {
			buffer = args.buf,
			silent = true,
			desc = "Undo tree help",
		})
	end,
})
