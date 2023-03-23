-- TODO: heirline config or toggleterm winbar

local open_mapping = '<leader>tt'

return {
  'akinsho/toggleterm.nvim',
  opts = {
    open_mapping = open_mapping,
    insert_mappings = false,
    on_open = function()
      vim.wo.signcolumn = 'no'
    end,
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  },
  keys = {
    { open_mapping, desc = 'Toggle Terminal' },
  },
}
