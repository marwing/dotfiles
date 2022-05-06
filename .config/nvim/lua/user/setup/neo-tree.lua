local ok, neotree = pcall(require, "neo-tree")
if not ok then
  return
end

neotree.setup {
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
    },
    use_libuv_file_watcher = true,
  },
}

vim.keymap.set('n', '<F7>', '<cmd>Neotree toggle filesystem show reveal<CR>')
vim.keymap.set('n', '\\s', '<cmd>Neotree float git_status<CR>')
vim.keymap.set('n', '\\b', '<cmd>Neotree toggle show buffers right<CR>')
