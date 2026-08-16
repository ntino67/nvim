return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- required by dap-ui
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		-- language-specific:
		"mfussenegger/nvim-dap-python", -- Python
		"leoluz/nvim-dap-go", -- Go
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		require("nvim-dap-virtual-text").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "delve", "codelldb" },
			automatic_installation = true,
		})
		local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(mason_python)
		require("dap-go").setup()

		-- auto open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- keymaps (pick your own, these are sensible defaults)
		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Condition: "))
		end)
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
		vim.keymap.set("n", "<leader>du", dapui.toggle)
	end,
}
