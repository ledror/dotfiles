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
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters = {
			clang_format = {
				args = {
					"--style",
					"{BasedOnStyle: GOOGLE, IndentWidth: 4, TabWidth: 4, ColumnLimit: 120, UseTab: Never, AlignAfterOpenBracket: AlwaysBreak, BinPackArguments: false, BinPackParameters: false, AllowShortFunctionsOnASingleLine: Empty, AccessModifierOffset: -4, IndentAccessModifiers: false}",
				},
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
			go = { "gofmt" },
			["_"] = { "trim_whitespace" },
		},
	},
}
