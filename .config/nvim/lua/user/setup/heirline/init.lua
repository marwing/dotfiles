local function debug(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = 'Config -- Heirline' })
end

local function setup(args)
  args = args or {}

  local configs = { {}, {} }

  for _, config in ipairs(args) do
    local ok, module = pcall(require, 'user.setup.heirline.configs.' .. config)
    if ok then
      if module.statusline then
        table.insert(configs[1], module.statusline)
      end
      if module.winbar then
        table.insert(configs[2], module.winbar)
      end
    else
      -- stylua: ignore
      debug('Error loading configuration "' .. config .. '"\n' ..
            'File missing or error in configuration:\n\n' ..
            module)
    end
  end

  return configs
end

local config = setup {
  'default',
}

require('heirline').setup(unpack(config))
vim.opt.laststatus = 3

function ReloadHeirline()
  require('plenary.reload').reload_module('user.setup.heirline')
  require('user.setup.heirline')
end
