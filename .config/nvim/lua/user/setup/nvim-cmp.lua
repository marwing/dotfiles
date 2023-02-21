local config = function()
  local cmp = require('cmp')

  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    },
    sources = {
      { name = 'git' },
      { name = 'calc' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'treesitter' },
      { name = 'buffer' },
      { name = 'emoji' },
    },
    experimental = {
      ghost_text = true,
    },
    formatting = {
      format = require('lspkind').cmp_format {
        mode = 'symbol_text',
        menu = {
          git = '[Git]',
          calc = '[Calc]',
          luasnip = '[LuaSnip]',
          nvim_lsp = '[LSP]',
          path = '[Path]',
          treesitter = '[TS]',
          buffer = '[Buffer]',
          dictionary = '[Dict]',
          emoji = '[Emoji]',
        },
      },
    },
  }

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'cmdline' },
    },
  })
end

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-calc',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-cmdline',
    {
      'petertriho/cmp-git',
      dependencies = 'nvim-lua/plenary.nvim',
      config = true,
    },
  },
  config = config,
  event = { 'InsertEnter', 'CmdlineEnter' },
}
