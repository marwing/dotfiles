return {
  'rcarriga/nvim-notify',
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(...)
      vim.notify = require('notify')
      return vim.notify(...)
    end
  end,
  opts = {
    timeout = 1000,
  },
  lazy = true,
}
