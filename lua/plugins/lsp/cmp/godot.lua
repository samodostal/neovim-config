local M = {}

local case_sensitive_filetypes = {
	gdscript = true,
	gdshader = true,
}

local completion_item_kind = vim.lsp.protocol.CompletionItemKind
local godot_item_order = setmetatable({}, { __mode = "k" })
local godot_own_items = setmetatable({}, { __mode = "k" })
local godot_member_cache = {}

local function completion_text(item) return item.filterText or item.label or "" end

local function case_sensitive_match(needle, haystack)
	local haystack_idx = 1

	for needle_idx = 1, #needle do
		local found_idx = haystack:find(needle:sub(needle_idx, needle_idx), haystack_idx, true)
		if not found_idx then return false end
		haystack_idx = found_idx + 1
	end

	return true
end

local function sort_godot_items(items, keyword)
	if keyword == "" then
		table.sort(items, function(a, b)
			local a_order = godot_item_order[a] or math.huge
			local b_order = godot_item_order[b] or math.huge
			if a_order ~= b_order then return a_order < b_order end
			return a.label < b.label
		end)

		return items
	end

	table.sort(items, function(a, b)
		if a.exact ~= b.exact then return a.exact == true end

		local a_text = completion_text(a)
		local b_text = completion_text(b)
		local a_has_prefix = a_text:sub(1, #keyword) == keyword
		local b_has_prefix = b_text:sub(1, #keyword) == keyword
		if a_has_prefix ~= b_has_prefix then return a_has_prefix end

		if a.score ~= b.score then return a.score > b.score end

		if a.sortText and b.sortText and a.sortText ~= b.sortText then return a.sortText < b.sortText end

		if #a_text ~= #b_text then return #a_text < #b_text end
		return a.label < b.label
	end)

	return items
end

local function setup_godot_completions()
	local fuzzy = require "blink.cmp.fuzzy"
	if fuzzy.godot_completions then return end

	local fuzzy_matches = fuzzy.fuzzy

	fuzzy.fuzzy = function(line, cursor_col, haystacks_by_provider, range)
		local items = fuzzy_matches(line, cursor_col, haystacks_by_provider, range)
		if not case_sensitive_filetypes[vim.bo.filetype] then return items end

		local start_col, end_col = fuzzy.get_keyword_range(line, cursor_col, range)
		local keyword = line:sub(start_col + 1, end_col)

		items = vim.tbl_filter(function(item)
			return case_sensitive_match(keyword, completion_text(item))
		end, items)

		return sort_godot_items(items, keyword)
	end

	fuzzy.godot_completions = true
end

local function enable_ctrl_w_backspace()
	local events = require("blink.cmp.completion.trigger").buffer_events
	if events then
		events.backspace_keycodes[vim.keycode "<C-w>"] = true
	end
end

local function setup_backspace_triggers()
	vim.api.nvim_create_autocmd("InsertEnter", { callback = enable_ctrl_w_backspace })
	vim.schedule(enable_ctrl_w_backspace)
end

local function setup_godot_lsp_refresh()
	local provider_list = require "blink.cmp.sources.lib.provider.list"
	if not provider_list.godot_refresh then
		local is_valid_for_context = provider_list.is_valid_for_context

		function provider_list:is_valid_for_context(context)
			if self.provider.id == "lsp" and case_sensitive_filetypes[vim.bo[context.bufnr].filetype] then
				local stale = self.context.bounds.length == 0
					or self.context.line:find("..", 1, true) ~= nil
					or self.context.line:sub(1, self.context.bounds.start_col - 1)
						~= context.line:sub(1, context.bounds.start_col - 1)

				if stale then return false end
			end

			return is_valid_for_context(self, context)
		end

		provider_list.godot_refresh = true
	end

	local lsp_cache = require "blink.cmp.sources.lsp.cache"
	if not lsp_cache.godot_refresh then
		local cache_get = lsp_cache.get

		lsp_cache.get = function(context, client)
			if case_sensitive_filetypes[vim.bo[context.bufnr].filetype] then
				local entry = lsp_cache.entries[client.id]
				if entry then
					local stale = entry.context.bounds.length == 0
						or entry.context.line:find("..", 1, true) ~= nil
						or entry.context.line:sub(1, entry.context.bounds.start_col - 1)
							~= context.line:sub(1, context.bounds.start_col - 1)

					if stale then return end
				end
			end

			return cache_get(context, client)
		end

		lsp_cache.godot_refresh = true
	end
end

local function collect_godot_file_symbols(bufnr, cursor_column)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "gdscript")
	if not ok or not parser then return {} end

	local parsed, trees = pcall(parser.parse, parser)
	if not parsed or not trees[1] then return {} end

	local items = {}
	local seen = {}

	for node in trees[1]:root():iter_children() do
		local name_node = node:field("name")[1]
		if name_node then
			local name = vim.treesitter.get_node_text(name_node, bufnr)
			if name ~= "" and not seen[name] then
				seen[name] = true

				local node_type = node:type()
				local label = name
				local insert_text = name
				local kind = nil

				if node_type == "function_definition" then
					label = name .. "()"
					insert_text = label
					kind = completion_item_kind.Method
				elseif node_type == "signal_statement" then
					kind = completion_item_kind.Event
				elseif node_type == "variable_statement" then
					kind = completion_item_kind.Property
				elseif node_type == "const_statement" then
					kind = completion_item_kind.Constant
				elseif node_type == "enum_definition" then
					kind = completion_item_kind.Enum
				elseif node_type == "class_name_statement" then
					kind = completion_item_kind.Class
				end

				if kind then
					table.insert(items, {
						label = label,
						filterText = name,
						insertText = insert_text,
						kind = kind,
						source_id = "lsp",
						source_name = "LSP",
						score_offset = 100,
						cursor_column = cursor_column,
					})
				end
			end
		end
	end

	return items
end

local autoload_specs = {}
local autoload_paths = {}
local script_symbols_cache = {}

local function godot_project_root(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then return end

	local project = vim.fs.find("project.godot", {
		upward = true,
		path = vim.fs.dirname(name),
		type = "file",
	})[1]

	return project and vim.fs.dirname(project)
end

local function autoloads_for_root(root)
	local cached = autoload_specs[root]
	if cached then return cached end

	local specs = {}
	local file = io.open(root .. "/project.godot", "r")
	if file then
		local in_autoload = false
		for line in file:lines() do
			if line:match "^%[" then
				in_autoload = line:match "^%[autoload%]" ~= nil
			elseif in_autoload then
				local name, spec = line:match '^([%w_]+)%s*=%s*"([^"]+)"'
				if name and spec then specs[name] = spec:gsub("^%*", "") end
			end
		end
		file:close()
	end

	autoload_specs[root] = specs
	return specs
end

local function resolve_uid(root, uid)
	local result = vim.fn.systemlist { "rg", "-l", "-F", uid, root, "--glob", "*.uid" }
	if vim.v.shell_error == 0 and result[1] then return result[1]:gsub("%.uid$", "") end
end

local function autoload_path(root, name)
	local cached = autoload_paths[root] and autoload_paths[root][name]
	if cached ~= nil then return cached or nil end

	autoload_paths[root] = autoload_paths[root] or {}
	local spec = autoloads_for_root(root)[name]
	local path = nil

	if spec then
		if spec:match "^res://" then
			path = root .. "/" .. spec:sub(7)
		elseif spec:match "^uid://" then
			path = resolve_uid(root, spec)
		end
	end

	autoload_paths[root][name] = path or false
	return path
end

local function names_from_root(root_node, source)
	local names = {}
	for node in root_node:iter_children() do
		local name_node = node:field("name")[1]
		if name_node then
			local name = vim.treesitter.get_node_text(name_node, source)
			if name ~= "" then names[name] = true end
		end
	end
	return names
end

local function current_buffer_symbol_names(bufnr)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "gdscript")
	if not ok or not parser then return {} end

	local parsed, trees = pcall(parser.parse, parser)
	if not parsed or not trees[1] then return {} end

	return names_from_root(trees[1]:root(), bufnr)
end

local function script_symbol_names(path)
	local stat = vim.uv.fs_stat(path)
	if not stat then return {} end

	local cached = script_symbols_cache[path]
	if cached and cached.mtime == stat.mtime.sec then return cached.names end

	local file = io.open(path, "r")
	if not file then return {} end
	local content = file:read "*a"
	file:close()

	local ok, parser = pcall(vim.treesitter.get_string_parser, content, "gdscript")
	if not ok or not parser then return {} end

	local parsed, trees = pcall(parser.parse, parser)
	if not parsed or not trees[1] then return {} end

	local names = names_from_root(trees[1]:root(), content)
	script_symbols_cache[path] = { mtime = stat.mtime.sec, names = names }
	return names
end

local function mark_own_items(context, items, receiver, used_file_fallback, use_current_file)
	if vim.bo[context.bufnr].filetype ~= "gdscript" then
		for _, item in ipairs(items) do godot_own_items[item] = nil end
		return
	end

	if used_file_fallback then
		for _, item in ipairs(items) do godot_own_items[item] = true end
		return
	end

	local own = nil
	if receiver == "self" or use_current_file then
		own = current_buffer_symbol_names(context.bufnr)
	elseif receiver then
		local root = godot_project_root(context.bufnr)
		if root then
			local path = autoload_path(root, receiver)
			if path then own = script_symbol_names(path) end
		end
	end

	if not own then
		for _, item in ipairs(items) do godot_own_items[item] = nil end
		return
	end

	for _, item in ipairs(items) do
		local label = item.label or ""
		local name = item.filterText or label:match "^([^(]+)" or label
		godot_own_items[item] = own[name] == true
	end
end
local function prepare_godot_items(context, items)
	if not case_sensitive_filetypes[vim.bo[context.bufnr].filetype] then return items end

	local keyword_start = context.bounds.start_col - 1
	local prefix = context.line:sub(1, keyword_start)
	local member_receiver = prefix:match "([%u][%w_]*)%.$"
	local receiver = member_receiver or (prefix:match "self%.$" and "self" or nil)
	local cache_key = nil
	local invalid_member = false

	if member_receiver then
		local client = vim.lsp.get_clients { bufnr = context.bufnr }[1]
		cache_key = (client and client.root_dir or vim.fn.getcwd()) .. "\0" .. member_receiver
		invalid_member = context.line:sub(context.cursor[2] + 1, context.cursor[2] + 1) == "."
	end

	local cached_items = cache_key and godot_member_cache[cache_key]
	if invalid_member and cached_items then
		items = vim.deepcopy(cached_items)
		for _, item in ipairs(items) do
			item.cursor_column = context.cursor[2]
		end
	end

	local used_file_fallback = false
	if
		#items == 0
		and context.bounds.length == 0
		and vim.bo[context.bufnr].filetype == "gdscript"
	then
		items = collect_godot_file_symbols(context.bufnr, context.cursor[2])
		used_file_fallback = true
	end

	mark_own_items(context, items, receiver, used_file_fallback, not prefix:match "[%w_]+%.$")

	for index, item in ipairs(items) do
		if godot_item_order[item] == nil then godot_item_order[item] = index end

		local is_callable = item.kind == completion_item_kind.Method
			or item.kind == completion_item_kind.Function
			or item.kind == completion_item_kind.Constructor

		if is_callable and item.filterText == nil then
			local name = item.label:match "^([^(]+)"
			if name then item.filterText = vim.trim(name) end
		end
	end

	if cache_key and not invalid_member and #items > 1 then
		if cached_items == nil or #cached_items ~= #items then
			godot_member_cache[cache_key] = vim.deepcopy(items)
		end
	end

	return items
end

function M.setup()
	setup_godot_completions()
	setup_godot_lsp_refresh()
	setup_backspace_triggers()
end

function M.prepare_items(context, items)
	return prepare_godot_items(context, items)
end

function M.label_highlight(ctx)
	local highlights = require("colorful-menu").blink_components_highlight(ctx)
	if godot_own_items[ctx.item] then
		local text = require("colorful-menu").blink_components_text(ctx)
		table.insert(highlights, { 0, #text, group = "BlinkCmpLabelOwn", priority = 20000 })
	end
	return highlights
end

return M
