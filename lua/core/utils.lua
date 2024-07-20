local M = {}

function M.table_size(t)
	local s = 0
	for _ in pairs(t) do
		s = s + 1
	end
	return s
end

function M.merge_tables(...)
	local result = {}

	for _, t in ipairs { ... } do
		for _, v in ipairs(t) do
			table.insert(result, v)
		end
	end

	return result
end

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
