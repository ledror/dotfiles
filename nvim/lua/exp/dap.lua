vim.pack.add({
	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		version = vim.version.range("^9"),
	},
})
vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/igorlfs/nvim-dap-view",
})

local dap = require("dap")
local dap_view = require("dap-view")

dap_view.setup({ auto_toggle = "keep_terminal", virtual_text = { enabled = true, position = "eol" } })

local map = vim.keymap.set
-- map({ "n" }, "<leader>K", function() require("dap.ui.widgets").hover() end, { desc = "" })
map({ "n" }, "<M-Del>", dap.pause, { desc = "Pause Debugger" })
map({ "n" }, "<F5>", dap.continue, { desc = "Continue Debugger" })
map({ "n" }, "<S-F5>", function() dap.disconnect({ terminateDebuggee = true }) end, { desc = "Disconnect Debugger" })
map({ "n" }, "<C-S-F5>", dap.restart, { desc = "Restart Debugger" })
map({ "n" }, "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map({ "n" }, "<C-S-F9>", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
map({ "n" }, "<F10>", dap.step_over, { desc = "Step Over" })
map({ "n" }, "<C-F10>", dap.run_to_cursor, { desc = "Run To Cursor" })
map({ "n" }, "<F11>", dap.step_into, { desc = "Step Into" })
map({ "n" }, "<S-F11>", dap.step_out, { desc = "Step Out" })
map({ "n" }, "<F6>", dap_view.add_expr, { desc = "Add Expression To Debugger View" })

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
