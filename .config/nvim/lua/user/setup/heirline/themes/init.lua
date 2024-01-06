local utils = require('user.setup.heirline.utils')

local colorschemes = setmetatable(
  vim.tbl_map(function(value)
    return 'user.setup.heirline.themes.' .. value
  end, {
    gruvbox = 'gruvbox',
    tokyonight = 'tokyonight',
    ['tokyonight-moon'] = 'tokyonight',
    ['tokyonight-storm'] = 'tokyonight',
    ['tokyonight-night'] = 'tokyonight',
  }),
  {
    __index = function(t, k)
      -- the tokyonight theme doesn't get it's colors from highlight groups (doesn't depend on the current nvim colorscheme)
      utils.notify('No theme for "' .. tostring(k) .. '". Falling back to tokyonight.', vim.log.levels.WARN)
      return t.tokyonight
    end,
  }
)

local function setup_colors(colorscheme)
  return require('user.utils').flatten(require(colorschemes[colorscheme])(), '.')
end

require('heirline').load_colors(setup_colors(vim.g.colors_name))

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function(data)
    require('heirline.utils').on_colorscheme(setup_colors(data.match))
  end,
  group = vim.api.nvim_create_augroup('user_heirline_colors', { clear = true }),
})
