local M = {}

M.sections = {
  lualine_a = { function() return 'CMake' end },
  lualine_b = { '%{cmake#statusline#GetBuildInfo(1)}' }, -- GetBuildInfo(active): active = 1 removes brackets
  lualine_c = { '%{cmake#statusline#GetCmdInfo()}' },
}

M.filetypes = { 'vimcmake' }

return M
