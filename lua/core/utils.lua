local M = {}

--- Safely requires a module
--- @param module string: The name of the module to require
--- @param silent boolean|nil: If true, suppresses error notifications (optional)
--- @return any: The required module, or nil if the module could not be loaded
function _G.safe_require(module, silent)
	silent = silent or false
	local ok, result = pcall(require, module)
	if not ok then
		if not silent then
			vim.notify(string.format("Could not safe_require: %s", module))
		end
		return nil
	end
	return result
end

--- Returns the size of a table
--- @param t table: The table whose size is to be calculated
--- @return number: The size of the table
function M.table_size(t)
	local s = 0
	for _ in pairs(t) do
		s = s + 1
	end
	return s
end

--- Merges any number of tables into one table
--- @vararg table: The tables to be merged
--- @return table: The merged table
function M.merge_tables(...)
	local result = {}

	for _, t in ipairs { ... } do
		for _, v in ipairs(t) do
			table.insert(result, v)
		end
	end

	return result
end

--- Sets up a keymap
--- @param mode string: The mode in which to set the keymap ("n", "v", or "i")
--- @param key string: The key to be mapped
--- @param cmd string: The command to be executed when the key is pressed
--- @param opts table|nil: The options for the keymap (optional)
function M.map(mode, key, cmd, opts) vim.api.nvim_set_keymap(mode, key, cmd, opts or { noremap = true, silent = true }) end

--- Sets up a menu with keybindings
--- @param title string: The title of the menu
--- @param key string: The key to open the menu
--- @param commands table: The commands to be included in the menu
function M.map_menu(title, key, commands)
	local Menu = safe_require "nui.menu"
	if not Menu then
		return
	end

	local lines = {}

	for _, command in ipairs(commands) do
		table.insert(lines, Menu.item(command))
	end

	local menu = Menu({
		position = "50%",
		size = { width = 25 },
		border = {
			style = "single",
			text = {
				top = " " .. title .. " ",
				top_align = "center",
			},
		},
		win_options = {
			number = true,
		},
	}, {
		lines = lines,
		keymap = {
			focus_next = { "j", "<Down>" },
			focus_prev = { "k", "<Up>" },
			close = { "<Esc>", "q" },
			submit = { "<CR>" },
		},
		on_submit = function(item) vim.cmd(item.cmd) end,
	})

	local modes = { "n", "v" }

	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, key, "", {
			noremap = true,
			silent = true,
			callback = function() menu:mount() end,
		})
	end
end

return M
