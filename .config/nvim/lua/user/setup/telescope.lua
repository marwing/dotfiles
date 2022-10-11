return {
  config = function()
    local telescope = require('telescope')

    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers')
    telescope.load_extension('notify')
  end,
  setup = function()
    vim.keymap.set('n', '<leader>fb', function()
      require('telescope.builtin').builtin()
    end, { desc = 'Telescope builtin' })
    vim.keymap.set('n', '<leader>fr', function()
      require('telescope.builtin').resume()
    end, { desc = 'Telescope resume' })
    vim.keymap.set('n', '<leader>ff', function()
      require('telescope.builtin').find_files()
    end, { desc = 'Telescope find_files' })
    vim.keymap.set('n', '<leader>fl', function()
      require('telescope.builtin').buffers { sort_lastused = true }
    end, { desc = 'Telescope buffers' })
  end,
}
