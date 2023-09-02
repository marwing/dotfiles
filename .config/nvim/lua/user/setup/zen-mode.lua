return {
  'folke/zen-mode.nvim',
  dependencies = 'folke/twilight.nvim',
  opts = {
    plugins = {
      tmux = { enabled = true },
    },
    window = {
      backdrop = 0.975,
      height = 0.9,
      width = 140,
      options = {
        signcolumn = 'no',
        number = false,
        relativenumber = false,
      },
    },
  },
  cmd = 'ZenMode',
}
