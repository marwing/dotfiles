local function config()
  local ls = require('luasnip')

  ls.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    delete_check_events = 'InsertEnter,TextChanged',
    enable_autosnippets = true,
    ext_opts = {
      [require('luasnip.util.types').choiceNode] = {
        active = {
          virt_text = { { ' <- choiceNode', 'Comment' } },
        },
      },
    },
  }

  ls.filetype_extend('all', { '_' })
  require('luasnip.loaders.from_snipmate').lazy_load()
  require('luasnip.loaders').load_lazy_loaded { 'all' }

  vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    if ls.jumpable(1) then
      ls.jump(1)
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

  -- SNIPPETS

  local s = ls.snippet
  local sn = ls.snippet_node
  local i = ls.insert_node
  local d = ls.dynamic_node
  local fmt = require('luasnip.extras.fmt').fmt

  ls.add_snippets('lua', {
    s(
      'req',
      fmt([[local {} = require('{}')]], {
        d(2, function(args)
          local module_name = args[1][1]
          local parts = vim.split(module_name, '.', true)
          local text = parts[#parts] or ''
          return sn(nil, i(1, text))
        end, { 1 }),
        i(1),
      })
    ),
  })
end

return {
  'L3MON4D3/LuaSnip',
  dependencies = 'honza/vim-snippets',
  config = config,
  ft = 'snippets',
  event = 'InsertEnter',
}
