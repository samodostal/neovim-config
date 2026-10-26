-- From TJDevries
-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/telescope/multi-ripgrep.lua

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

return function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.uv.cwd()
	opts.shortcuts = opts.shortcuts or {}
	opts.pattern = opts.pattern or "%s"

	local file_entry_maker = make_entry.gen_from_file(opts)
	local vimgrep_entry_maker = make_entry.gen_from_vimgrep(opts)

	local function entry_maker(line)
		if line:match ":%d+:%d+:" then
			return vimgrep_entry_maker(line)
		end
		return file_entry_maker(line)
	end

	local custom_grep = finders.new_async_job {
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local sep = prompt:find("  ", 1, true)
			local search = sep and prompt:sub(1, sep - 1) or prompt
			local glob = sep and vim.trim(prompt:sub(sep + 2)) or ""

			if glob == "" and vim.trim(search) == "" then
				return nil
			end

			local file_mode = search == ""
			local args = { "rg" }

			if file_mode then
				table.insert(args, "--files")
			else
				table.insert(args, "-e")
				table.insert(args, search)
			end

			if glob ~= "" then
				table.insert(args, "-g")
				local pattern = opts.shortcuts[glob] or glob
				table.insert(args, string.format(opts.pattern, pattern))
			end

			local extra = file_mode and { "--color=never" }
				or {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				}

			return vim.list_extend(args, extra)
		end,
		entry_maker = entry_maker,
		cwd = opts.cwd,
	}

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Live Grep (with shortcuts)",
			finder = custom_grep,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end
