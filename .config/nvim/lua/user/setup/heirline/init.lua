local function config()
  local notify = require('user.setup.heirline.utils').notify

  require('user.setup.heirline.themes.init')

  local function setup(args, opts)
    args = args or {}
    opts = opts or {}

    local default_opts = { statusline = true, winbar = true, tabline = false, statuscolumn = false }
    opts = vim.tbl_extend('force', default_opts, opts)

    local configs = {
      statusline = opts.statusline and { fallthrough = false, hl = { fg = 'stl.fg', bg = 'stl.bg' } },
      winbar = opts.winbar and { fallthrough = false, hl = { fg = 'wb.fg', bg = 'wb.bg' } },
      tabline = opts.tabline and { fallthrough = false },
      statuscolumn = opts.statuscolumn and { fallthrough = false },
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
        if opts.statuscolumn and module.statuscolumn then
          table.insert(configs.statuscolumn, module.statuscolumn)
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
    'vimcmake',
    'neo-tree',
    'tagbar',
    'terminal',
    'special',
    'default',
  }

  require('heirline').setup(config)
  vim.opt.laststatus = 3
end

return {
  {
    'rebelot/heirline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = config,
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    lazy = true, -- loaded in on_attach
  },
  {
    'SmiteshP/nvim-gps',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
    event = 'VeryLazy',
  },
}
