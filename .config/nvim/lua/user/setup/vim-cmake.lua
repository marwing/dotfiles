vim.g.cmake_build_dir_location = 'build'
vim.g.cmake_link_compile_commands = 1
vim.g.cmake_generate_options = { '-GNinja' }

local map = require('user.utils').keymap('<leader>c', 'n')
map('b', '<Plug>(CMakeBuild)')
map('t', '<Plug>(CMakeTest)')
map('r', '<cmd>CMakeSwitch Release<CR>')
map('d', '<cmd>CMakeSwitch Debug<CR>')
map('q', '<Plug>(CMakeClose)')
