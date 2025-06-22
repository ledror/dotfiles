-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	opts = { flavour = "mocha" },
-- 	config = function() vim.cmd("colorscheme catppuccin") end,
-- }

return {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
        vim.opt.background = "dark"
        vim.cmd("colorscheme oxocarbon")
    end
}
