return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = { flavour = "mocha" },
	config = function() vim.cmd("colorscheme catppuccin") end,
}

-- return {
-- 	"nyoom-engineering/oxocarbon.nvim",
-- 	config = function()
-- 		vim.opt.background = "dark"
-- 		vim.cmd("colorscheme oxocarbon")
-- 	end,
-- }

-- return {
-- 	"projekt0n/github-nvim-theme",
-- 	name = "github-theme",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		require("github-theme").setup({})
--
-- 		vim.cmd("colorscheme github_dark_high_contrast")
-- 	end,
-- }
