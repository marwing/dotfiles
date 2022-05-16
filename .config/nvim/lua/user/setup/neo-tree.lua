return {
  config = function()
    local neotree = require('neo-tree')

    neotree.setup {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
        use_libuv_file_watcher = true,
      },
    }
  end,
  setup = function()
    vim.g.neo_tree_remove_legacy_commands = true

    vim.keymap.set('n', '<F7>', '<cmd>Neotree toggle filesystem show reveal<CR>')
    vim.keymap.set('n', '\\s', '<cmd>Neotree float git_status<CR>')
    vim.keymap.set('n', '\\b', '<cmd>Neotree toggle show buffers right<CR>')
  end,
}
