local function complete_godot_class(arg_lead)
	local completions = {}
	local prefix = arg_lead:lower()

	for _, class in ipairs(require("gdscript-extended-lsp").get_classes()) do
		if class:lower():find(prefix, 1, true) then table.insert(completions, class) end
	end

	return completions
end

return {
	{
		"Teatek/gdscript-extended-lsp.nvim",
		main = "gdscript-extended-lsp",
		lazy = false,
		opts = {
			view_type = "split",
			split_side = false,
			keymaps = {
				declaration = "gD",
			},
		},
		config = function(_, opts)
			require("gdscript-extended-lsp").setup(opts)

			vim.api.nvim_create_user_command("GodotDoc", function(command)
				local symbol = vim.trim(command.args)
				if symbol == "" then symbol = vim.fn.expand "<cword>" end
				if symbol == "" then return end

				require("gdscript-extended-lsp").request_doc_class(symbol)
			end, {
				nargs = "*",
				force = true,
				complete = function(arg_lead) return complete_godot_class(arg_lead) end,
				desc = "Open Godot docs for a class or the symbol under the cursor",
			})
		end,
	},
}
