local ok, cmp = pcall(require, "cmp")
if not ok or
    not pcall(require, "luasnip") or
    not pcall(require, "lspkind") then
  return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'buffer' },
    -- { name = 'dictionary' },
    { name = 'emoji' },
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = "symbol_text",
      menu = ({
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        treesitter = "[TS]",
        buffer = "[Buffer]",
        dictionary = "[Dict]",
        emoji = "[Emoji]",
      })
    }),
  },
}

-- require'cmp_dictionary'.setup {
--   dic = {
--     ["*"] = { "/usr/share/dict/german", "/usr/share/dict/words" }
--   }
-- }
