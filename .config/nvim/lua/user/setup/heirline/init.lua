local notify = require('user.utils').notify('Heirline Config')

local function setup(args)
  args = args or {}

  local configs = {
    statusline = { fallthrough = false },
    winbar = { fallthrough = false },
    -- tabline = { fallthrough = false },
  }

  for _, config in ipairs(args) do
    local ok, module = pcall(require, 'user.setup.heirline.configs.' .. config)
    if ok then
      if configs.statusline and module.statusline then
        table.insert(configs.statusline, module.statusline)
      end
      if configs.winbar and module.winbar then
        table.insert(configs.winbar, module.winbar)
      end
      if configs.tabline and module.tabline then
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
