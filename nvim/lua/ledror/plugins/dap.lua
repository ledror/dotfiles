return {
	{

		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				"<leader>K",
				function() require("dap.ui.widgets").hover() end,
			},
			{
				"<F5>",
				function() require("dap").continue() end,
			},
			{
				"<S-F5>",
				function() require("dap").disconnect({ terminateDebuggee = true }) end,
			},
			{
				"<C-S-F5>",
				function() require("dap").restart() end,
			},
			{
				"<F9>",
				function() require("dap").toggle_breakpoint() end,
			},
			{
				"<C-S-F9>",
				function() require("dap").clear_breakpoints() end,
			},
			{
				"<F10>",
				function() require("dap").step_over() end,
			},
			{
				"<C-F10>",
				function() require("dap").run_to_cursor() end,
			},
			{
				"<F11>",
				function() require("dap").step_into() end,
			},
			{
				"<S-F11>",
				function() require("dap").step_out() end,
			},
		},
		config = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb",
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DiagnosticError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DiagnosticInfo",
				linehl = "Visual",
				numhl = "",
			})
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		-- let the plugin lazy load itself
		lazy = false,
		---@module 'dap-view'
		---@type dapview.Config
		keys = {
			{
				"<F6>",
				function() require("dap-view").add_expr() end,
			},
		},
		opts = {
			auto_toggle = true,
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			commented = true,
            virt_text_pos = "eol",
		},
	},
}
