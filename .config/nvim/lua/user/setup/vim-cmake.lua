return {
  'cdelledonne/vim-cmake',
  init = function()
    vim.g.cmake_build_dir_location = 'build'
    vim.g.cmake_link_compile_commands = 1
    vim.g.cmake_generate_options = { '-GNinja', '-DENABLE_DEVELOPER_MODE:BOOL=ON' }
  end,
  -- stylua: ignore
  keys = {
    { '<leader>cb', '<Plug>(CMakeBuild)',           desc = 'CMake build' },
    { '<leader>ct', '<Plug>(CMakeTest)',            desc = 'CMake test' },
    { '<leader>cr', '<cmd>CMakeSwitch Release<CR>', desc = 'CMake switch Release' },
    { '<leader>cd', '<cmd>CMakeSwitch Debug<CR>',   desc = 'CMake switch Debug' },
    { '<leader>cq', '<Plug>(CMakeClose)',           desc = 'CMake close' },
  },
  cmd = { 'CMakeGenerate', 'CMakeClean' },
}
