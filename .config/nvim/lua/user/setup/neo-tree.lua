return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        visible = true,
      },
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { '<leader>tf', '<cmd>Neotree toggle filesystem show reveal<cr>', desc = 'NeoTree filesystem' },
    { '<leader>tb', '<cmd>Neotree toggle buffers show right<cr>',     desc = 'NeoTree buffers' },
    { '<leader>tg', '<cmd>Neotree toggle git_status float<cr>',       desc = 'NeoTree git_status' },
  },
  cmd = 'Neotree',
  ft = 'netrw', -- FIXME: loads neo-tree but doesn't trigger hijack
}
