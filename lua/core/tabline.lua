return {
	setup = function()
		local current = vim.api.nvim_get_current_tabpage()
		local parts = {}

		for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
			local nr = vim.api.nvim_tabpage_get_number(tab)
			local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))

			local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			if name == "" then
				name = "Empty"
			end

			local hl = (tab == current) and "TabLineSel" or "TabLine"
			parts[#parts + 1] = ("%%#%s#%%%dT %d %s %%T"):format(hl, nr, nr, name)
		end

		return table.concat(parts)
	end,
}
