local M = {}

local socket = "/tmp/godotremote"
local started = false
local listening = false

local function project_root()
	local root = vim.fs.root(vim.fn.getcwd(), "project.godot")
	if root then
		return root
	end

	local name = vim.api.nvim_buf_get_name(0)
	if name ~= "" then
		return vim.fs.root(name, "project.godot")
	end
end

local function socket_is_live()
	local ok, channel = pcall(vim.fn.sockconnect, "pipe", socket, { rpc = false })
	if not ok or channel == 0 then
		return false
	end
	vim.fn.chanclose(channel)
	return true
end

local function ensure()
	if listening or not project_root() then
		return
	end

	if socket_is_live() then
		listening = true
		return
	end

	if vim.uv.fs_stat(socket) then
		vim.uv.fs_unlink(socket)
	end

	if pcall(vim.fn.serverstart, socket) then
		listening = true
	end
end

function M.setup()
	if started then
		return
	end
	started = true

	ensure()

	vim.api.nvim_create_autocmd("DirChanged", {
		callback = function() ensure() end,
	})

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function(args)
			local filetype = vim.bo[args.buf].filetype
			if filetype == "gdscript" or filetype == "gdshader" then
				ensure()
			end
		end,
	})
end

return M
