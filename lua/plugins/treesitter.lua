return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup {}
			require("nvim-treesitter").install "all"

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo[0][0].foldmethod = "expr"
					end
				end,
			})
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup {
				select = { lookahead = true },
				move = { set_jumps = true },
			}

			local move = require "nvim-treesitter-textobjects.move"
			local select = require "nvim-treesitter-textobjects.select"

			local targets = {
				f = "function",
				m = "function",
				c = "class",
				l = "loop",
				i = "conditional",
				b = "block",
				a = "parameter",
				k = "call",
			}

			local function act_on(query, keys)
				local pos = vim.api.nvim_win_get_cursor(0)
				select.select_textobject(query, "textobjects")
				vim.cmd("normal " .. keys)
				pcall(vim.api.nvim_win_set_cursor, 0, pos)
			end

			local function map(lhs, mode, fn, desc) vim.keymap.set(mode, lhs, fn, { desc = desc }) end

			for key, name in pairs(targets) do
				local outer, inner = "@" .. name .. ".outer", "@" .. name .. ".inner"
				local jump = { "n", "x", "o" }

				map("m" .. key, jump, function() move.goto_previous_start(outer, "textobjects") end, "Top of " .. name)
				map("me" .. key, jump, function() move.goto_next_end(outer, "textobjects") end, "End of " .. name)
				map("mn" .. key, jump, function() move.goto_next_start(outer, "textobjects") end, "Next " .. name)
				map(
					"mp" .. key,
					jump,
					function() move.goto_previous_start(outer, "textobjects") end,
					"Previous " .. name
				)
				map(
					"mv" .. key,
					{ "n", "x" },
					function() select.select_textobject(outer, "textobjects") end,
					"Select " .. name
				)
				map(
					"mV" .. key,
					{ "n", "x" },
					function() select.select_textobject(inner, "textobjects") end,
					"Select inner " .. name
				)

				map("my" .. key, "n", function() act_on(outer, "y") end, "Yank " .. name)
				if key ~= "c" then
					map("gc" .. key, "n", function() act_on(outer, "gc") end, "Comment out " .. name)
				end
			end

			local function qf_jump(dir)
				local info = vim.fn.getqflist { size = 0, idx = 0 }
				if info.size == 0 then
					vim.api.nvim_echo({ { "Quickfix is empty" } }, false, {})
					return
				end
				local cmd
				if dir == "next" then
					cmd = info.idx >= info.size and "cfirst" or "cnext"
				else
					cmd = info.idx <= 1 and "clast" or "cprev"
				end
				vim.cmd(cmd)
				local idx = vim.fn.getqflist({ idx = 0 }).idx
				vim.api.nvim_echo({ { ("Quickfix (%d/%d)"):format(idx, info.size) } }, false, {})
			end

			map("mq", "n", function() qf_jump "next" end, "Next quickfix item")
			map("mpq", "n", function() qf_jump "prev" end, "Previous quickfix item")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
