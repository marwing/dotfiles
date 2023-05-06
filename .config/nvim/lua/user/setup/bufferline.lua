local icons = {
  error = '󰅚 ',
  warning = '󰀪 ',
  info = '󰋽 ',
  hint = '󰌶 ',
}

return {
  'akinsho/bufferline.nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      show_buffer_close_icons = false,
      show_tab_indicators = false,
      always_show_bufferline = false,
      diagnostics_indicator = function(count, level)
        return ' ' .. icons[level] .. count
      end,
    },
  },
  event = 'VeryLazy',
}
