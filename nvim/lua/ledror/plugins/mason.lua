return {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
