-- i use nvim-tree, so no real reason to use netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.guicursor = ""
vim.opt.colorcolumn = ""
vim.opt.signcolumn = "yes"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.undofile = true

-- show inline on default, see mappings.lua for toggle
vim.diagnostic.config({ virtual_text = true })

vim.opt.scrolloff = 5
