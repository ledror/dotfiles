-- Opts
do
	-- Enable faster startup by caching compiled Lua modules
	vim.loader.enable()

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	vim.g.have_nerd_font = true

	vim.o.relativenumber = true
	vim.o.nu = true

	vim.o.cursorline = true
	vim.o.signcolumn = "yes"
	vim.o.guicursor = ""

	vim.o.mouse = "a"

	vim.o.breakindent = true
	vim.o.undofile = true

	vim.o.ignorecase = true
	vim.o.smartcase = true

	vim.o.updatetime = 200
	vim.o.timeoutlen = 3000

	vim.o.splitright = true
	vim.o.splitbelow = true

	vim.o.inccommand = "split"

	vim.o.scrolloff = 10

	vim.o.confirm = true

	vim.o.tabstop = 4
	vim.o.softtabstop = 4
	vim.o.shiftwidth = 4
	vim.o.expandtab = true
end

-- Autocmds
do
	local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = yank_group,
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "IncSearch",
				timeout = 70,
			})
		end,
	})
end

-- Plugin Installations
do
	vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
	vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
	vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
	vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
	vim.pack.add({
		{
			src = "https://github.com/saghen/blink.cmp",
			version = vim.version.range("1.*"),
		},
		{
			src = "https://github.com/rafamadriz/friendly-snippets",
		},
	})
	vim.pack.add({
		"https://github.com/nvim-tree/nvim-web-devicons",
		"https://github.com/nvim-lualine/lualine.nvim",
	})
	vim.pack.add({ "https://github.com/folke/flash.nvim" })
	vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
	vim.pack.add({
		"https://github.com/folke/noice.nvim",
		"https://github.com/MunifTanjim/nui.nvim",
	})
	vim.pack.add({ "https://github.com/folke/snacks.nvim" })
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
end

-- Plugin Setups
do
	require("nvim-autopairs").setup()
	require("lazydev").setup()
	require("nvim-treesitter")
	require("blink.cmp").setup({
		keymap = {
			preset = "super-tab",
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = false },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	})
	require("lualine").setup({
		options = {
			theme = "onedark",
		},
	})
	require("flash").setup({
		modes = {
			search = {
				enabled = true,
			},
		},
	})
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	})
	require("noice").setup({
		presets = {
			command_palette = true,
		},
	})
	require("snacks").setup({
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = false },
		input = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = false },
		notifier = { enabled = false },
		explorer = {
			enabled = true,
			replace_netrw = true,
			hidden = true,
			respect_gitignore = true,
		},
		picker = {
			enabled = true,
			layout = {
				preset = "default",
			},
		},
	})
	require("conform").setup({
		formatters = {
			stylua = {
				inherit = true,
				prepend_args = { "--collapse-simple-statement=FunctionOnly" },
			},
		},
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			["_"] = { "trim_whitespace" },
		},
	})
end

-- LSP Configs
do
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("clangd")
end

-- Mappings
do
	-- System clipboard management
	vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
	vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
	vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
	vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])

	vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

	-- moving entire lines up/down
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

	-- centers cursor after scroll
	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("n", "<C-u>", "<C-u>zz")

	-- Flash
	local flash = require("flash")
	vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
	vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
	vim.keymap.set({ "o" }, "r", function() flash.remote() end, { desc = "Remote Flash" })
	vim.keymap.set({ "x", "o" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })

	-- Snacks
	local Snacks = require("snacks")
	vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
	vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
	vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
	vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
	vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "File Explorer" })
	vim.keymap.set(
		"n",
		"<leader>fc",
		function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
		{ desc = "Find Config File" }
	)
	vim.keymap.set("n", "<leader>sb", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
	vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
	vim.keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
	vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
	vim.keymap.set(
		"n",
		"<leader>sD",
		function() Snacks.picker.diagnostics_buffer() end,
		{ desc = "Buffers Diagnostics" }
	)
	vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
	vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
	vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
	vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
	vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
	vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
	vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
	vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
	vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
	vim.keymap.set("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
	vim.keymap.set("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
	vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
	vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notifications" })
	vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })

	-- Conform
	local conform = require("conform")
	vim.keymap.set("n", "<leader>fm", function() conform.format({ async = true }) end, { desc = "Format" })
end
