return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'gbrlsnchs/telescope-lsp-handlers.nvim',
  },
  config = function()
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers') -- TODO: replace with custom implementation to lazy load telescope
    telescope.load_extension('notify')

    local map = require('user.utils').keymap('<leader>f', 'n')
    local tb = require('telescope.builtin')
    map('b', tb.builtin, { desc = 'Telescope builtin' })
    map('r', tb.resume, { desc = 'Telescope resume' })
    map('f', tb.find_files, { desc = 'Telescope find_files' })
    map('l', function()
      tb.buffers { sort_lastused = true }
    end, { desc = 'Telescope buffers' })
    map('g', tb.live_grep, { desc = 'Telescope live_grep' })
  end,
  event = 'VeryLazy',
}
