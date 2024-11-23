return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim", },
	config = function()
		local builtin = require("telescope.builtin")

		-- file picker
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.git_files)
		vim.keymap.set("n", "<leader>fw", builtin.live_grep)

		-- vim picker
		vim.keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find)

		-- lsp picker
		vim.keymap.set("n", "gr", builtin.lsp_references)
		vim.keymap.set("n", "gi", builtin.lsp_implementations)
		vim.keymap.set("n", "gd", builtin.lsp_definitions)
		vim.keymap.set("n", "gt", builtin.lsp_references)
		vim.keymap.set("n", "gn", builtin.lsp_incoming_calls)
		vim.keymap.set("n", "gN", builtin.lsp_outgoing_calls)
		
	end
}
