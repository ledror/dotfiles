return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function() require("conform").format({ async = true }) end,
		},
	},
	opts = {
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
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			["_"] = { "trim_whitespace" },
		},
	},
}
