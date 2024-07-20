return {
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>uf", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon add file" },
			{ "<leader>uc", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon show menu" },
			{ "<leader>uh", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon navigate to file 1" },
			{ "<leader>um", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon navigate to file 2" },
			{ "<leader>uw", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon navigate to file 3" },
			{ "<leader>uv", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon navigate to file 4" },
			{ "<leader>uz", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "Harpoon navigate to file 5" },
		},
	},
}
