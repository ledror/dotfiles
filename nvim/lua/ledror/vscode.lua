local vscode = require("vscode")

vim.keymap.set({ "n", "v" }, "grr", function()
    vscode.action('editor.action.goToReferences')
end
)
