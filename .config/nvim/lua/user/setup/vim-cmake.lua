return {
  'cdelledonne/vim-cmake',
  dev = true,
  init = function()
    vim.g.cmake_build_dir_location = 'build'
    vim.g.cmake_link_compile_commands = 1
    vim.g.cmake_generate_options = { '-GNinja', '-DENABLE_DEVELOPER_MODE:BOOL=ON' }
  end,
  keys = {
    { '<leader>cb', '<Plug>(CMakeBuild)' },
    { '<leader>ct', '<Plug>(CMakeTest)' },
    { '<leader>cr', '<cmd>CMakeSwitch Release<CR>' },
    { '<leader>cd', '<cmd>CMakeSwitch Debug<CR>' },
    { '<leader>cq', '<Plug>(CMakeClose)' },
  },
  cmd = { 'CMakeGenerate' },
}
