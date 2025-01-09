return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			-- snippet engine
			"L3MON4D3/LuaSnip",
			dependencies = "rafamadriz/friendly-snippets",
			run = "make install_jsregexp"
		},
		{
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	config = function()
		local cmp = require("cmp")
		local ls = require("luasnip")
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if ls.expand_or_locally_jumpable() then
						ls.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s", }),
			}),
			sources = cmp.config.sources({
				{
					name = "luasnip",
				},
				{
					name = "nvim_lsp",
				},
				{
					name = "buffer",
				},
			}),
		})
	end,
}
