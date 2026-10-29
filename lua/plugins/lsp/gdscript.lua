local M = {}

M.host = "127.0.0.1"
M.port = 6005

local retry_interval = 1000
local handshake_timeout = 10000

local timer = nil
local redraw_timer = nil
local probing = false
local started = false
local waiting = false
local tick

local function filetype_matches(bufnr)
	local filetype = vim.bo[bufnr].filetype
	return filetype == "gdscript" or filetype == "gdshader"
end

local function buffer_is_target(bufnr)
	return vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == "" and filetype_matches(bufnr)
end

local function has_target_buffer()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if buffer_is_target(bufnr) then
			return true
		end
	end
	return false
end

local function has_client()
	for _, client in ipairs(vim.lsp.get_clients { name = "gdscript" }) do
		if not client:is_stopped() then
			return true
		end
	end
	return false
end

local function stop_polling()
	if timer and not timer:is_closing() then
		timer:stop()
		timer:close()
	end
	timer = nil
end

local function stop_redraw()
	if redraw_timer and not redraw_timer:is_closing() then
		redraw_timer:stop()
		redraw_timer:close()
	end
	redraw_timer = nil
end

local function set_waiting(value)
	if waiting == value then
		return
	end

	waiting = value

	if waiting then
		redraw_timer = vim.uv.new_timer()
		if redraw_timer then
			redraw_timer:start(0, 100, function()
				vim.schedule(function()
					if not waiting or vim.v.exiting ~= vim.NIL then
						return
					end
					if has_client() or not has_target_buffer() then
						set_waiting(false)
						return
					end
					vim.cmd.redrawstatus()
				end)
			end)
		end
		return
	end

	stop_redraw()
	if vim.v.exiting == vim.NIL then
		vim.cmd.redrawstatus()
	end
end

local function clear_uninitialized()
	for _, client in ipairs(vim.lsp.get_clients { name = "gdscript", _uninitialized = true }) do
		if not client.initialized then
			client:stop(true)
		end
	end
end

local function start_clients()
	local config = vim.lsp.config.gdscript
	if not config then
		return
	end

	clear_uninitialized()

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if buffer_is_target(bufnr) then
			local client_config = vim.deepcopy(config)
			vim.lsp.start(client_config, {
				bufnr = bufnr,
				_root_markers = client_config.root_markers,
			})
		end
	end
end

local function probe(callback)
	local tcp = vim.uv.new_tcp()
	if not tcp then
		callback(false)
		return
	end

	local done = false
	local function finish(connected)
		if done then
			return
		end
		done = true
		tcp:close()
		callback(connected)
	end

	tcp:connect(M.host, M.port, function(err) finish(err == nil) end)
end

local function ensure_polling()
	if timer or not has_target_buffer() or has_client() then
		return
	end

	timer = vim.uv.new_timer()
	timer:start(0, retry_interval, function() vim.schedule(tick) end)
end

tick = function()
	if has_client() or not has_target_buffer() then
		stop_polling()
		set_waiting(false)
		return
	end
	if probing then
		return
	end

	probing = true
	probe(function(connected)
		probing = false
		if not connected then
			vim.schedule(function()
				if not has_client() then
					set_waiting(true)
				end
			end)
			return
		end

		vim.schedule(function()
			if has_client() then
				stop_polling()
				set_waiting(false)
				return
			end

			stop_polling()
			start_clients()

			vim.defer_fn(function()
				if has_client() then
					set_waiting(false)
					return
				end
				if not has_target_buffer() then
					set_waiting(false)
					stop_polling()
					return
				end

				clear_uninitialized()
				ensure_polling()
			end, handshake_timeout)
		end)
	end)
end

function M.is_waiting() return waiting end

function M.ensure()
	if has_client() then
		set_waiting(false)
		start_clients()
		stop_polling()
		return
	end
	ensure_polling()
end

function M.on_exit()
	if vim.v.exiting ~= vim.NIL then
		return
	end
	vim.schedule(function() ensure_polling() end)
end

function M.setup()
	if started then
		return
	end
	started = true

	vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
		callback = function(args)
			if filetype_matches(args.buf) then
				M.ensure()
			end
		end,
	})

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			set_waiting(false)
			stop_polling()
		end,
	})

	M.ensure()
end

return M
