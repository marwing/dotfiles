return {
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
        use_libuv_file_watcher = true,
        follow_current_file = true,
      },
    }
  end,
  setup = function()
    vim.g.neo_tree_remove_legacy_commands = true

    local map = require('user.utils').keymap('<leader>t', 'n')
    map('f', '<cmd>Neotree toggle filesystem show reveal<CR>')
    map('b', '<cmd>Neotree toggle buffers show right<CR>')
    map('g', '<cmd>Neotree toggle git_status float<CR>')
  end,
}
