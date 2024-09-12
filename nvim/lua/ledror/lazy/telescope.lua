return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>gw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>gW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>gs", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
		vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>b", function() builtin.buffers({ sort_lastused = true }) end)
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, {})
	end,
}
