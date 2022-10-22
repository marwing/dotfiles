-- TODO: heirline config or toggleterm winbar
require('toggleterm').setup {
  open_mapping = '<leader>tt',
  insert_mappings = false,
  on_open = function()
    vim.wo.signcolumn = 'no'
  end,
  direction = 'float',
  float_opts = {
    border = 'curved'
  }
}
