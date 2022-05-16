vim.g.cmake_build_dir_location = 'build'
vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-GNinja' }
vim.g.cmake_statusline = 0

vim.keymap.set('n', 'cb', '<Plug>(CMakeBuild)')
vim.keymap.set('n', 'cr', '<cmd>CMakeSwitch Release<CR>')
vim.keymap.set('n', 'cd', '<cmd>CMakeSwitch Debug<CR>')
vim.keymap.set('n', 'cq', '<Plug>(CMakeClose)')
