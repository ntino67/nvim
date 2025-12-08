return {
  'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local conf = require("telescope.config").values
      local harpoon = require("harpoon")

      -- telescope keymaps
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.keymap.set('n', '<C-r>', builtin.git_files, { desc = 'Telescope find git files' })

      -- harpoon telescope integration
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" })
    end,
}
