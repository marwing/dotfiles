local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local builtin = require('telescope.builtin')

telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension("ui-select")
telescope.load_extension('lsp_handlers')

vim.keymap.set('n', '<C-A-t>', builtin.builtin)
vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<C-A-p>', builtin.buffers)
