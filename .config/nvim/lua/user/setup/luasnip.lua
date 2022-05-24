local ls = require('luasnip')

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
}

ls.filetype_extend('all', { '_' })
require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders').load_lazy_loaded { '', 'all' }

vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
