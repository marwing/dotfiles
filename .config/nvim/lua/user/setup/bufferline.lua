local icons = {
  error = ' ', -- xf659
  warning = ' ', -- xf529
  info = ' ', -- xf7fc
  hint = ' ', -- xf835
}

require('bufferline').setup {
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    offsets = { { filetype = 'neo-tree', text = 'File Explorer', text_align = 'center' } },
    show_buffer_close_icons = false,
    show_tab_indicators = false,
    always_show_bufferline = false,
    diagnostics_indicator = function(count, level)
      return ' ' .. icons[level] .. count
    end,
  },
}
