return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		config = function()
			local luasnip = require "luasnip"

			luasnip.config.set_config {
				history = true,
				updateevents = "TextChanged,TextChangedI",
				override_builtin = true,
			}

			require("luasnip.loaders.from_vscode").lazy_load()

			vim.snippet.expand = luasnip.lsp_expand

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.active = function(filter)
				filter = filter or {}
				filter.direction = filter.direction or 1

				if filter.direction == 1 then
					return luasnip.expand_or_jumpable()
				else
					return luasnip.jumpable(filter.direction)
				end
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.jump = function(direction)
				if direction == 1 then
					if luasnip.expandable() then
						return luasnip.expand_or_jump()
					else
						return luasnip.jumpable(1) and luasnip.jump(1)
					end
				else
					return luasnip.jumpable(-1) and luasnip.jump(-1)
				end
			end

			vim.snippet.stop = luasnip.unlink_current
		end,
	},
}
