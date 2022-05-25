return {
  config = function()
    local telescope = require('telescope')

    telescope.setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {}
        }
      }
    }

    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers')
    telescope.load_extension('notify')
  end,
  setup = function()
    -- lazy-load support for telescope-ui-select
    vim.ui.select = function(...)
      require('telescope').load_extension('ui-select')
      vim.ui.select(...)
    end

    vim.keymap.set('n', '<C-A-t>', function() require('telescope.builtin').builtin() end)
    vim.keymap.set('n', '<C-A-r>', function() require('telescope.builtin').resume() end)
    vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end)
    vim.keymap.set('n', '<C-A-p>', function() require('telescope.builtin').buffers({ sort_lastused = true }) end)
  end,
}
