return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		local lsp_lines = require("lsp_lines")
		lsp_lines.setup()
		local my_toggle = function()
			local new_virtual_text = not vim.diagnostic.config().virtual_text
			local new_virtual_lines = not vim.diagnostic.config().virtual_lines
			vim.diagnostic.config({ virtual_text = new_virtual_text })
			vim.diagnostic.config({ virtual_lines = new_virtual_lines })
		end
		vim.diagnostic.config({ virtual_text = true })
		vim.diagnostic.config({ virtual_lines = false })
		vim.keymap.set("", "<Leader>l", my_toggle)
	end,
}
