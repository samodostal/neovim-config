local palette = {
	bg = "#000000",
	bg1 = "#1d2021",
	bg2 = "#282828",
	bg3 = "#3c3836",
	bg4 = "#504945",
	fg = "#ebdbb2",
	fg0 = "#fbf1c7",
	gray = "#928374",
	red = "#fb4934",
	orange = "#fe8019",
	yellow = "#fabd2f",
	green = "#b8bb26",
	aqua = "#8ec07c",
	blue = "#83a598",
	purple = "#d3869b",
}

local function apply_highlights()
	local set = vim.api.nvim_set_hl

	set(0, "NonText", { fg = palette.bg3 })
	set(0, "BlinkCmpLabelMatch", { fg = palette.blue })
	set(0, "BlinkCmpLabelOwn", { bold = true })
	set(0, "BlinkCmpSource", { link = "Comment" })
	set(0, "BlinkCmpLabelDescription", { link = "Comment" })
	set(0, "BlinkCmpMenu", { fg = palette.fg, bg = "NONE" })
	set(0, "BlinkCmpMenuBorder", { fg = palette.bg4, bg = "NONE" })
	set(0, "BlinkCmpMenuSelection", { bg = palette.bg3, fg = palette.fg0 })
	set(0, "BlinkCmpLabel", { fg = palette.fg, bg = "NONE" })
	set(0, "BlinkCmpKind", { fg = palette.green, bg = "NONE" })
	set(0, "BlinkCmpDocBorder", { fg = palette.bg4, bg = "NONE" })
	set(0, "BlinkCmpSignatureHelpBorder", { fg = palette.bg4, bg = "NONE" })
	set(0, "SnacksIndent", { fg = palette.bg2 })
	set(0, "SnacksIndentScope", { fg = palette.bg3 })
	set(0, "FlashMatch", { fg = palette.yellow })
	set(0, "FlashCurrent", { fg = palette.yellow })
	set(0, "FlashLabel", { fg = palette.aqua })
	set(0, "LspReferenceText", { bg = palette.bg3 })
	set(0, "LspReferenceRead", { bg = palette.bg3 })
	set(0, "LspReferenceWrite", { bg = palette.bg3, underline = true })

	set(0, "CursorLine", { bg = "NONE" })
	set(0, "CursorColumn", { bg = palette.bg1 })
	set(0, "CursorLineNr", { fg = palette.yellow, bold = true })
	set(0, "LineNr", { fg = "#665c54" })
	set(0, "WinSeparator", { fg = palette.bg3 })

	set(0, "StatusLine", { fg = palette.gray })
	set(0, "StatusLineNC", { fg = "#665c54" })
	set(0, "StatusLineTerm", { fg = palette.gray })
	set(0, "StatusLineTermNC", { fg = "#665c54" })
	set(0, "WinBar", { fg = palette.gray })
	set(0, "WinBarNC", { fg = "#665c54" })

	set(0, "TabLine", { fg = palette.gray, bg = "NONE" })
	set(0, "TabLineSel", { fg = palette.fg, bold = true, bg = "NONE" })
	set(0, "TabLineFill", { bg = "NONE" })

	set(0, "ST_EmptySpace", { bg = "NONE" })
	set(0, "StatusFileInfo", { fg = palette.fg })
	set(0, "St_file_sep", { fg = palette.bg3 })
	set(0, "StatusGitInfo", { fg = palette.gray })
	set(0, "StatusLSPError", { fg = palette.red })
	set(0, "StatusLSPWarn", { fg = palette.yellow })
	set(0, "StatusLSPHint", { fg = palette.aqua })
	set(0, "StatusLSPInfo", { fg = palette.blue })
	set(0, "StatusLSPStatus", { fg = palette.gray })
	set(0, "StatusCwd", { fg = palette.gray })
	set(0, "StatusCursor", { fg = palette.fg })

	set(0, "StatusVimNormal", { fg = palette.fg, bold = true })
	set(0, "StatusVimInsert", { fg = palette.green, bold = true })
	set(0, "StatusVimVisual", { fg = palette.yellow, bold = true })
	set(0, "StatusVimReplace", { fg = palette.red, bold = true })
	set(0, "StatusVimSelect", { fg = palette.purple, bold = true })
	set(0, "StatusVimCmd", { fg = palette.blue, bold = true })
	set(0, "StatusVimTerm", { fg = palette.aqua, bold = true })
	set(0, "StatusModified", { fg = palette.orange, bold = true })

	set(0, "DiagnosticVirtualTextError", { fg = palette.red })
	set(0, "DiagnosticVirtualTextWarn", { fg = palette.yellow })
	set(0, "DiagnosticVirtualTextInfo", { fg = palette.blue })
	set(0, "DiagnosticVirtualTextHint", { fg = palette.aqua })
	set(0, "DiagnosticVirtualTextOk", { fg = palette.green })

	set(0, "NormalFloat", { fg = palette.fg, bg = "NONE" })
	set(0, "FloatBorder", { fg = palette.gray, bg = "NONE" })
	set(0, "TreesitterContext", { fg = palette.fg, bg = "NONE" })
	set(0, "TreesitterContextLineNumber", { fg = palette.gray, bg = "NONE" })
	set(0, "TreesitterContextSeparator", { fg = palette.gray, bg = "NONE" })
	set(0, "TreesitterContextBottom", { bg = "NONE" })
	set(0, "TreesitterContextLineNumberBottom", { bg = "NONE" })

	local syntax = {
		["@variable"] = palette.fg,
		["@variable.builtin"] = palette.fg,
		["@variable.parameter"] = palette.orange,
		["@variable.member"] = palette.blue,
		["@property"] = palette.blue,
		["@field"] = palette.blue,
		["@parameter"] = palette.orange,
		["@operator"] = palette.fg,
		["@punctuation.bracket"] = palette.gray,
		["@punctuation.delimiter"] = palette.gray,
		["@punctuation.special"] = palette.gray,
		["@number"] = palette.fg,
		["@number.float"] = palette.fg,
		["@constant"] = palette.yellow,
		["@constant.builtin"] = palette.yellow,
		["@boolean"] = palette.yellow,
		["@keyword"] = palette.red,
		["@keyword.function"] = palette.red,
		["@keyword.operator"] = palette.red,
		["@function"] = palette.green,
		["@function.call"] = palette.green,
		["@function.method"] = palette.green,
		["@string"] = palette.yellow,
		["@string.escape"] = palette.orange,
		["@type"] = palette.aqua,
		["@type.builtin"] = palette.aqua,
		["@namespace"] = palette.fg,
		["@module"] = palette.fg,
		["@label"] = palette.fg,
		["@comment"] = palette.gray,
		["@comment.documentation"] = palette.gray,
		["@lsp.type.variable"] = palette.fg,
		["@lsp.type.parameter"] = palette.orange,
		["@lsp.type.property"] = palette.blue,
		["@lsp.typemod.variable.defaultLibrary"] = palette.aqua,
		["@lsp.type.function"] = palette.green,
		["@lsp.type.method"] = palette.green,
		["@lsp.type.class"] = palette.aqua,
		["@lsp.type.keyword"] = palette.red,
		["@lsp.type.string"] = palette.yellow,
		["@lsp.type.number"] = palette.fg,
		Comment = palette.gray,
		Identifier = palette.fg,
		Function = palette.green,
		Keyword = palette.red,
		String = palette.yellow,
		Type = palette.aqua,
		Constant = palette.yellow,
		Number = palette.fg,
		Operator = palette.fg,
		Delimiter = palette.gray,
		Special = palette.aqua,
		Statement = palette.red,
		PreProc = palette.aqua,
	}

	for group, fg in pairs(syntax) do
		set(0, group, { fg = fg })
	end
end

return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.o.termguicolors = true
			vim.o.background = "dark"

			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_transparent_background = 2
			vim.g.gruvbox_material_disable_italic_comment = 1
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.g.gruvbox_material_colors_override = {
				bg0 = { "#000000", "232" },
				bg1 = { "#1d2021", "234" },
				bg2 = { "#1d2021", "234" },
				bg3 = { "#282828", "235" },
				bg4 = { "#3c3836", "237" },
				bg5 = { "#504945", "239" },
				bg_statusline1 = { "#1d2021", "234" },
				bg_statusline2 = { "#1d2021", "234" },
				bg_statusline3 = { "#282828", "235" },
				fg0 = { "#fbf1c7", "230" },
				fg1 = { "#ebdbb2", "223" },
				bg_current_word = { "#3c3836", "237" },
			}

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = apply_highlights,
			})

			vim.cmd.colorscheme "gruvbox-material"
			apply_highlights()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},
	{ "MunifTanjim/nui.nvim", lazy = false },
	{
		"2kabhishek/nerdy.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function() require("telescope").load_extension "nerdy" end,
		keys = {
			{
				"<leader>fi",
				"<cmd>lua require('telescope').extensions.nerdy.nerdy()<cr>",
				desc = "Open nerd icons picker",
			},
		},
	},
}
