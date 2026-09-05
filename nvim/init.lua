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
	vim.o.swapfile = false
	vim.o.backup = false
	vim.o.writebackup = false

	vim.o.ignorecase = true
	vim.o.smartcase = true

	vim.o.updatetime = 100
	vim.o.timeout = false

	vim.o.splitright = true
	vim.o.splitbelow = true

	vim.o.inccommand = "split"

	vim.o.scrolloff = 10

	vim.o.confirm = true

	vim.o.tabstop = 4
	vim.o.softtabstop = 4
	vim.o.shiftwidth = 4
	vim.o.expandtab = true

	vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

	vim.cmd.colorscheme("catppuccin")
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
	vim.pack.add({ "https://github.com/folke/snacks.nvim" })
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
	vim.pack.add({ "https://github.com/nvim-mini/mini.misc" })
	vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
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
			implementation = "rust",
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
				enabled = false,
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
	require("snacks").setup({
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		indent = { enabled = false },
		input = { enabled = true },
		quickfile = { enabled = false },
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
			python = { "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt", lsp_format = "fallback" },
			["_"] = { "trim_whitespace" },
		},
	})
	local mini_misc = require("mini.misc")
	mini_misc.setup_termbg_sync()
	require("fidget").setup()
end

-- LSP Configs
do
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("clangd")
	vim.lsp.enable("basedpyright")
	vim.lsp.config("basedpyright", {
		settings = {
			python = {
				pythonPath = vim.fn.exepath("python"),
			},
		},
	})
end

-- Mappings
do
	local map = vim.keymap.set
	-- System clipboard management
	map({ "n", "v" }, "<leader>y", [["+y]])
	map({ "n", "v" }, "<leader>Y", [["+Y]])
	map({ "n", "v" }, "<leader>p", [["+p]])
	map({ "n", "v" }, "<leader>P", [["+P]])

	map({ "n", "v" }, "<leader>d", [["_d]])

	map("n", "gK", function()
		local new_virtual_lines = not vim.diagnostic.config().virtual_lines
		local new_virtual_text = not vim.diagnostic.config().virtual_text
		vim.diagnostic.config({ virtual_text = new_virtual_text, virtual_lines = new_virtual_lines })
	end, { desc = "Toggle diagnostic virtual_lines" })
	map("n", "gT", function()
		local new_toggle = not vim.lsp.inlay_hint.is_enabled()
		vim.lsp.inlay_hint.enable(new_toggle)
	end, { desc = "Toggle inlay type hints" })
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
	map("n", "<C-f>", vim.diagnostic.open_float)
	map("n", "<leader>rn", vim.lsp.buf.rename)
	map("n", "<leader>cr", vim.lsp.codelens.run)
	map(
		"n",
		"<leader>cl",
		function() vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled()) end,
		{ desc = "Toggle CodeLens" }
	)
	map({ "n" }, "<leader>cd", ":cd %:p:h<CR>")

	-- moving entire lines up/down
	map("v", "J", ":m '>+1<CR>gv=gv")
	map("v", "K", ":m '<-2<CR>gv=gv")

	-- centers cursor after scroll
	map("n", "<C-d>", "<C-d>zz")
	map("n", "<C-u>", "<C-u>zz")

	-- Flash
	local flash = require("flash")
	map({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
	map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
	map({ "o" }, "r", flash.remote, { desc = "Remote Flash" })
	map({ "x", "o" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })

	-- Snacks
	local Snacks = require("snacks")
	-- Top pickers
	map("n", "<leader><space>", Snacks.picker.smart, { desc = "Smart Find Files" })
	map("n", "<leader>sb", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
	map("n", "<leader>,", Snacks.picker.buffers, { desc = "Buffers" })
	map("n", "<leader>/", Snacks.picker.grep, { desc = "Grep" })
	map({ "n", "v" }, "<leader>gw", Snacks.picker.grep_word, { desc = "Grep Word" })
	map("n", "<leader>:", Snacks.picker.command_history, { desc = "Command History" })
	map("n", "<leader>e", Snacks.picker.explorer, { desc = "File Explorer" })
	map(
		"n",
		"<leader>fc",
		function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
		{ desc = "Find Config File" }
	)
	map("n", "<leader>s/", Snacks.picker.search_history, { desc = "Search History" })
	map("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
	map("n", "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffers Diagnostics" })
	-- VIM
	map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
	map("n", '<leader>s"', Snacks.picker.registers, { desc = "Registers" })
	map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
	map("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
	map("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
	-- LSP
	map("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition" })
	map("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration" })
	map("n", "gr", Snacks.picker.lsp_references, { nowait = true, desc = "References" })
	map("n", "gi", Snacks.picker.lsp_implementations, { desc = "Goto Implementation" })
	map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto T[y]pe Definition" })
	map("n", "gai", Snacks.picker.lsp_incoming_calls, { desc = "C[a]lls Incoming" })
	map("n", "gao", Snacks.picker.lsp_outgoing_calls, { desc = "C[a]lls Outgoing" })
	map("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "LSP Symbols" })
	map("n", "<leader>n", Snacks.picker.notifications, { desc = "Notifications" })
	map("n", "<leader>un", Snacks.notifier.hide, { desc = "Dismiss All Notifications" })
	-- GIT
	map("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
	map("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
	map("n", "<leader>gs", Snacks.picker.git_status, { desc = "Git Status" })
	map("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
	map("n", "<leader>gd", Snacks.picker.git_diff, { desc = "Git Diff (Hunks)" })
	map("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })
	map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
	map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

	-- Conform
	local conform = require("conform")
	map("n", "<leader>fm", function() conform.format({ async = true }) end, { desc = "Format" })
end

do
	require("exp.dap")
end
