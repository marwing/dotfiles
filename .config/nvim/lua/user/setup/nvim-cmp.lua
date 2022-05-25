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
