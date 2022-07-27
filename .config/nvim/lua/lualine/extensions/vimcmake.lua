local M = {}

M.sections = {
  lualine_a = { function() return 'CMake' end },
  lualine_b = { '%{cmake#GetInfo().config}' },
  lualine_c = { '%{cmake#GetInfo().status}' },
}

M.filetypes = { 'vimcmake' }

return M
