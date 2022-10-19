local notify = require('user.setup.heirline.utils').notify

local colors = require('user.setup.heirline.colors')

local function setup(args, opts)
  args = args or {}
  opts = opts or {}

  local default_opts = { statusline = true, winbar = true, tabline = false }
  opts = vim.tbl_extend('force', default_opts, opts)

  local configs = {
    statusline = opts.statusline and { fallthrough = false, hl = colors.default },
    winbar = opts.winbar and { fallthrough = false, hl = { fg = colors.gray } },
    tabline = opts.tabline and { fallthrough = false },
  }

  for _, config in ipairs(args) do
    local ok, module = pcall(require, 'user.setup.heirline.configs.' .. config)
    if ok then
      if opts.statusline and module.statusline then
        table.insert(configs.statusline, module.statusline)
      end
      if opts.winbar and module.winbar then
        table.insert(configs.winbar, module.winbar)
      end
      if opts.tabline and module.tabline then
        table.insert(configs.tabline, module.tabline)
      end
    else
      -- stylua: ignore
      notify('Error loading configuration "' .. config .. '"\n' ..
            'File missing or error in configuration:\n\n' ..
            module)
    end
  end

  return configs
end

local config = setup {
  -- 'help',
  'neo-tree',
  'terminal',
  'special',
  'default',
}

require('heirline').setup(config.statusline, config.winbar, config.tabline)
vim.opt.laststatus = 3

return {
  reload = function()
    require('plenary.reload').reload_module('user.setup.heirline')
    require('user.setup.heirline')
  end,
}
