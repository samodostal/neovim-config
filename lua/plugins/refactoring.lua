return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("refactoring").setup { show_success_message = true }
			require("telescope").load_extension "refactoring"

			local map = require("core.utils").map

			map("n", "<leader>rr", "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>")
			map("v", "<leader>rr", "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>")
		end,
	},
}
