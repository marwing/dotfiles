return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_page_title = '${name}'
    vim.g.mkdp_browser = 'electron'
  end,
  ft = 'markdown',
}
