-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'lua_ls', 'rust_analyzer', 'eslint', 'omnisharp', 'clangd', 'gopls', 'ts_ls'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lspconfig_defaults,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  },
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
	  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	  ['<C-y>'] = cmp.mapping.confirm({select = true}),
	  ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'uh', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'B', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>.,;', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>.h', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '-h', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', '=h', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>.ia', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>.oo', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>.ol', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-j>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})
