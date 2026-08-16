return {
	"seblyng/roslyn.nvim",
	ft = "cs",
	opts = {
		cmd = {
			"roslyn",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fn.stdpath("log") .. "/roslyn",
			"--stdio",
		},
	},
}
