return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		sync_install = false,
		indent = { enable = false },
		highlithg = { enable = true },
	},
}
