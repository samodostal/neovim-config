return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require "dap"
			local dap_ui = require "dapui"
			local map = require("core.utils").map

			dap_ui.setup()

			-- Highlights
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "GitSignsDelete", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "C●", texthl = "GitSignsDelete", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "GitSignsDelete", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "GitSignsDelete", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "○", texthl = "GitSignsChange", linehl = "", numhl = "" }
			)

			-- Keymaps
			map("n", "<leader>ds", "<cmd>lua require('dapui').open()<cr>")
			map(
				"n",
				"<leader>de",
				"<cmd>lua require('dapui').close()<cr><cmd>lua require('dap').clear_breakpoints()<cr>"
			)
			map("n", "<leader>dd", ":lua require('dap').continue()<cr>")
			map("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<cr>")
			map("n", "<leader>dl", ":lua require('dap').step_over()<cr>")
			map("n", "<leader>dj", ":lua require('dap').step_into()<cr>")
			map("n", "<leader>dk", ":lua require('dap').step_out()<cr>")
			map("n", "<leader>dc", ":lua require('dap').run_to_cursor()<cr>")

			-- Adapters
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			-- Configurations
			dap.configurations.c = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/run/current-system/sw/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}
		end,
	},
}
