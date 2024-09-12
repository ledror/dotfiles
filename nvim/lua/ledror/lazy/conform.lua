return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters = {
				clang_format = {
					args = { "--style", "{BasedOnStyle: GOOGLE, IndentWidth: 4, TabWidth: 4, ColumnLimit: 100}" },
				},
				stylua = {
					inherit = true,
					prepend_args = { "--collapse-simple-statement=FunctionOnly" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "ruff_format" },
				go = { "gofumpt", "goimports", "golines" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				objc = { "clang_format" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		vim.keymap.set("n", "<leader>fm", conform.format)
	end,
}
