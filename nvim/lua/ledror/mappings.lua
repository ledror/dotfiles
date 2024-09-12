vim.g.mapleader = " "

-- very useful
vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>")

-- insert mode navigations
vim.keymap.set("i", "<C-b>", "<Esc>^i")
vim.keymap.set("i", "<C-e>", "<Esc>$a")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format) -- using conform instead

-- actually, these are the best remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- for some reason this mapping exists, idk what it does but it fucks with me
vim.keymap.set("n", "<C-l>", "<nop>")

-- terminal stuff
vim.keymap.set("n", "<M-t>", ":terminal <CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")

vim.keymap.set("n", "<M-v>", ":vsplit <CR>")
vim.keymap.set("n", "<M-h>", ":split <CR>")

vim.keymap.set('', "<S-Down>", "<nop>")
vim.keymap.set('', "<S-Up>", "<nop>")

-- for wrapped lines
local options = { noremap = true, silent = true, expr = true }

function Gvcountfunc(k)
    return ((vim.v.count == 0) and ('g' .. k)) or k
end

vim.keymap.set('', 'j', function() return Gvcountfunc('j') end, options)
vim.keymap.set('', 'k', function() return Gvcountfunc('k') end, options)
vim.keymap.set('', '<Down>', function() return Gvcountfunc('j') end, options)
vim.keymap.set('', '<Up>', function() return Gvcountfunc('k') end, options)
