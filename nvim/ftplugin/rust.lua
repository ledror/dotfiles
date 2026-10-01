vim.treesitter.start()
vim.keymap.set(
	"n",
	"<F5>",
	function() vim.cmd.RustLsp("debuggables") end,
	{ silent = true, buffer = true, desc = "RustLsp Debuggables" }
)
