return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	version = "1.*", -- use release tag, not main (main requires Rust toolchain for building)
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default", -- C-Space to open, C-n/C-p to cycle, C-y to confirm
			["<C-d>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-q>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "buffer", "path" },
		},
		completion = {
			list = { selection = { preselect = false, auto_insert = false } },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
