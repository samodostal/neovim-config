local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.numberwidth = 1

opt.wrap = true
opt.linebreak = true

opt.smartcase = true
opt.ignorecase = true

opt.shiftwidth = 2
opt.tabstop = 2

opt.autoread = true

opt.hlsearch = false
opt.inccommand = "split"

opt.matchpairs = "(:),{:},[:],<:>"

opt.guicursor = "i:block"
opt.cursorline = true
opt.signcolumn = "yes:1"
opt.laststatus = 3

opt.termguicolors = true

opt.scrolloff = 2
opt.sidescrolloff = 2
opt.splitkeep = "screen"

opt.splitbelow = true
opt.splitright = true

opt.updatetime = 0
opt.swapfile = false
opt.undofile = true

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append "c"

opt.list = true
opt.listchars:append("eol:↴")

opt.conceallevel = 0
opt.statusline = "%!v:lua.require('core.statusline').setup()"

-- formatoptions overriden by ftplugin (:verbose set formatoptions)
vim.api.nvim_create_autocmd("FileType", {
	callback = function() opt.formatoptions:remove "o" end,
})
