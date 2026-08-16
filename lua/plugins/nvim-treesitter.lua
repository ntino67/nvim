return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"markdown",
			"markdown_inline",
			"javascript",
			"bash",
			"json",
			"lua",
			"go",
			"c_sharp", -- add whatever else you use
		})

		-- fenced-block tags -> parser names
		vim.treesitter.language.register("javascript", "js")
		vim.treesitter.language.register("bash", "sh")

		-- the rewrite no longer auto-enables highlighting; core does it per buffer
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end
				local ok, available = pcall(vim.treesitter.language.add, lang)
				if ok and available then
					pcall(vim.treesitter.start, args.buf, lang)
				end
			end,
		})
	end,
}
