require("ledror.opt")
require("ledror.mappings")

if vim.g.vscode then
    require("ledror.vscode")
else
    require("ledror.lazy")
end

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
