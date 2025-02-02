local M = {}

-- ! IMPORTANT ! - short names of packgaes
M.managed_separately = {
	"ts_ls",
}

-- ! IMPORTANT ! - short names of packgaes
M.disable_inlayhints = {}

M.lsp = {
	-- [ Common ]
	"yaml-language-server",
	"json-lsp",
	"taplo",
	"lemminx",
	-- "ltex-ls",

	-- [ Unix ]
	-- "nil",
	"ansible-language-server",
	"bash-language-server",

	-- [ Embedded ]
	"clangd",
	"cmake-language-server",
	"rust-analyzer",
	-- "asm-lsp",
	"arduino-language-server",

	-- [ Web dev ]
	"typescript-language-server",
	"html-lsp",
	"css-lsp",
	-- 'tailwindcss-language-server'
	-- 'graphql-language-service-cli'
	-- 'deno'

	-- [ Game dev ]
	"gdtoolkit",

	-- [ Docker ]
	"docker-compose-language-service",
	"dockerfile-language-server",

	-- [ Neovim ]
	"lua-language-server",

	-- [ Python ]
	"pyright",

	-- [ Dotnet ]
	"omnisharp",

	-- [ PHP ]
	"intelephense",

	-- [ Go ]
	"gopls",

	-- [ Haskell ]
	-- "haskell-language-server",

	-- [ Database ]
	"sqlls",
}

M.dap = {
	"go-debug-adapter",
	"node-debug2-adapter",
	"chrome-debug-adapter",
	"debugpy",
	"cpptools",
}

-- Packages for linters and formatters also include filetypes, for easy integration with conform.nvim and nvim-lint

-- Check linters availability at: https://github.com/mfussenegger/nvim-lint
M.linters_with_ft = {
	cpp = { "cpplint" },
	lua = { "luacheck" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	gdscript = { toolkit = "gdtoolkit", command = "gdlint" },
}

-- Check formatters availability at: https://github.com/stevearc/conform.nvim
M.formatters_with_ft = {
	lua = { "stylua" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	html = { "prettier" },
	yaml = { "prettier" },
	cpp = { "clang_format" },
	c = { "clang_format" },
	python = { "black" },
	haskell = { "ormolu" },
	cs = { "csharpier" },
	nix = { "nixpkgs_fmt" },
	gdscript = { toolkit = "gdtoolkit", command = "gdformat" },
}

return M
