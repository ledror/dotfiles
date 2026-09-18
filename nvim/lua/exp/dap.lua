vim.pack.add({
	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		version = vim.version.range("^9"),
	},
})
vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/igorlfs/nvim-dap-view",
})
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/Civitasv/cmake-tools.nvim",
})

local dap = require("dap")
local dap_view = require("dap-view")
local cmake = require("cmake-tools")

-- "open" (open on launch, never auto-close) instead of a toggle: auto-closing the view
-- when the session ends crashes nvim if the debuggee ran in the integrated terminal
dap_view.setup({ auto_toggle = "open", virtual_text = { enabled = true, position = "eol" } })

-- codelldb ships inside the vscode-lldb extension; pick the newest one installed
local function codelldb_command()
	local exe = vim.fn.has("win32") == 1 and "codelldb.exe" or "codelldb"
	local pattern = vim.fn.expand("~/.vscode/extensions/vadimcn.vscode-lldb-*/adapter/" .. exe)
	local found = vim.fn.glob(pattern, true, true)
	local function version_of(path)
		return vim.version.parse(path:match("vscode%-lldb%-([%d%.]+)") or "") or vim.version.parse("0.0.0")
	end
	table.sort(found, function(a, b) return vim.version.lt(version_of(a), version_of(b)) end)
	return found[#found] or exe
end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_command(),
		args = { "--port", "${port}" },
		-- adapter dies with the parent process instead of lingering (required on Windows)
		detached = false,
	},
}

-- Fallbacks for non-CMake projects; inside a CMake project <F5> goes through cmake-tools
for _, ft in ipairs({ "c", "cpp" }) do
	dap.configurations[ft] = {
		{
			name = "Launch executable",
			type = "codelldb",
			request = "launch",
			program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
			cwd = "${workspaceFolder}",
			args = {},
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Attach to process",
			type = "codelldb",
			request = "attach",
			pid = function() return require("dap.utils").pick_process() end,
		},
	}
end

cmake.setup({
	cmake_build_directory = "build/${variant:buildType}",
	cmake_regenerate_on_save = true,
	cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
	cmake_compile_commands_options = {
		-- soft links need admin/developer mode on Windows, so just copy it next to the sources
		action = "copy",
		target = vim.uv.cwd,
	},
	-- :CMakeDebug generates + builds the launch target, then hands it to nvim-dap with this
	cmake_dap_configuration = {
		name = "CMake",
		type = "codelldb",
		request = "launch",
		stopOnEntry = false,
		runInTerminal = false,
		-- program runs in the dap-view terminal; "console" would send its stdout to the
		-- adapter's own stdout, where nothing shows it
		terminal = "integrated",
	},
	cmake_executor = {
		name = "quickfix",
		-- follow the build while it runs, then close it if nothing went wrong
		opts = { show = "always", auto_close_when_success = true },
	},
	-- cmake-tools drives nvim-notify by hand: it opens a new window for every line of
	-- output and resizes each one to the width of a different message, which leaves a
	-- stack of boxes with their text cut off. Report the result ourselves instead.
	cmake_notifications = { executor = { enabled = false }, runner = { enabled = false } },
	cmake_runner = { name = "terminal" },
	cmake_virtual_text_support = true,
})

local function continue()
	-- in a CMake project, build + debug the selected launch target instead of asking
	-- for a dap configuration (prompts for a launch target the first time)
	if not dap.session() and cmake.is_cmake_project() then
		return vim.cmd("CMakeDebug")
	end
	dap.continue()
end

local map = vim.keymap.set
-- map({ "n" }, "<leader>K", function() require("dap.ui.widgets").hover() end, { desc = "" })
map({ "n" }, "<M-Del>", dap.pause, { desc = "Pause Debugger" })
map({ "n" }, "<F5>", continue, { desc = "Continue Debugger" })
map({ "n" }, "<S-F5>", function() dap.disconnect({ terminateDebuggee = true }) end, { desc = "Disconnect Debugger" })
map({ "n" }, "<C-S-F5>", dap.restart, { desc = "Restart Debugger" })
map({ "n" }, "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map({ "n" }, "<C-S-F9>", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
map({ "n" }, "<F10>", dap.step_over, { desc = "Step Over" })
map({ "n" }, "<C-F10>", dap.run_to_cursor, { desc = "Run To Cursor" })
map({ "n" }, "<F11>", dap.step_into, { desc = "Step Into" })
map({ "n" }, "<S-F11>", dap.step_out, { desc = "Step Out" })
map({ "n" }, "<F6>", dap_view.add_expr, { desc = "Add Expression To Debugger View" })
map({ "n" }, "<F7>", "<cmd>DapViewToggle<cr>", { desc = "Toggle Debugger View" })

-- CMake
map("n", "<leader>mg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>mb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>mr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
map("n", "<leader>md", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
map("n", "<leader>mD", "<cmd>CMakeQuickDebug<cr>", { desc = "CMake Debug (Pick Target)" })
map("n", "<leader>mc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
map("n", "<leader>mx", "<cmd>CMakeStopRunner<cr>", { desc = "CMake Stop Runner" })
map("n", "<leader>mt", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select Launch Target" })
map("n", "<leader>mT", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Build Target" })
map("n", "<leader>mv", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
map("n", "<leader>mk", "<cmd>CMakeSelectKit<cr>", { desc = "CMake Select Kit" })
map("n", "<leader>ma", "<cmd>CMakeLaunchArgs<cr>", { desc = "CMake Launch Args" })

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DiagnosticError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DiagnosticInfo",
	linehl = "Visual",
	numhl = "",
})
