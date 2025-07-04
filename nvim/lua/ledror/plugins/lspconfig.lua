return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },

	-- example calling setup directly for each LSP
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig = require("lspconfig")

		lspconfig["lua_ls"].setup({ capabilities = capabilities })
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			cmd = { "clangd", "--background-index", "--clang-tidy" },
		})
	end,
}
