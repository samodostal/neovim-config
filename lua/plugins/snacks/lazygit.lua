local M = {}

local corners = { { "╭", "╮" }, { "┌", "┐" }, { "╔", "╗" } }

local function has_popup(buf)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
		line = line:gsub("%s+$", "")
		for _, corner in ipairs(corners) do
			local init = 1
			while true do
				local start = line:find(corner[1], init, true)
				if not start then
					break
				end
				local finish = line:find(corner[2], start + #corner[1], true)
				if finish and start > 1 and finish + #corner[2] - 1 < #line then
					return true
				end
				init = start + #corner[1]
			end
		end
	end
	return false
end

function M.hide(self)
	local buf = self.buf
	local job = vim.b[buf].terminal_job_id
	local popup = has_popup(buf)
	local before

	if popup then
		before = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
	end
	if job then
		vim.api.nvim_chan_send(job, "\27")
	end
	if not popup then
		self:hide()
		return
	end

	vim.defer_fn(function()
		if not (self:win_valid() and self:buf_valid()) then
			return
		end
		local after = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
		if after == before then
			self:hide()
		end
	end, 120)
end

return M
