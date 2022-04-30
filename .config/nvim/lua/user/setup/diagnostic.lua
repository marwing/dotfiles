vim.diagnostic.config {
  update_in_insert = true,
  severity_sort = true,
  virtual_text = { source = "always" },
  float = { source = "always" },
}

vim.keymap.set('n', 'dD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)
