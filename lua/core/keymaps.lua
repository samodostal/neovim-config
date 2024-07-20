local map = require("core.utils").map

vim.g.mapleader = " "

map("n", "<leader>", "<nop>")

map("n", "<leader>t", ":b#<CR>")

map("v", "<", "<gv")
map("v", ">", ">gv")
