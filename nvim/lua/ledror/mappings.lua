vim.g.mapleader = " "

-- remove search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- insert mode navigations
vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-e>", "<Esc>A")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- avoid random <C-c> quirks
vim.keymap.set("i", "<C-c>", "<Esc>")

-- delete without yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- paste without yank
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yanks to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- moving entire lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- joins next line but keeps cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- centers cursor after scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")

-- split shortcuts
vim.keymap.set("n", "<M-v>", ":vsplit <CR>")
vim.keymap.set("n", "<M-h>", ":split <CR>")

-- useless maps, make them do nothing
vim.keymap.set("", "<S-Down>", "<nop>")
vim.keymap.set("", "<S-Up>", "<nop>")

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- some floats
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<C-f>", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>l", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_text = not new_config, virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set({ "n" }, "<C-k>", vim.diagnostic.open_float)

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set({ "n" }, "<leader>cd", ":cd %:p:h<CR>")
