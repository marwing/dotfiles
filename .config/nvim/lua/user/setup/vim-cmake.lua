vim.g.cmake_build_dir_location = 'build'
vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-GNinja' }

vim.keymap.set('n', '<leader>cb', '<Plug>(CMakeBuild)')
vim.keymap.set('n', '<leader>ct', '<Plug>(CMakeTest)')
vim.keymap.set('n', '<leader>cr', '<cmd>CMakeSwitch Release<CR>')
vim.keymap.set('n', '<leader>cd', '<cmd>CMakeSwitch Debug<CR>')
vim.keymap.set('n', '<leader>cq', '<Plug>(CMakeClose)')
