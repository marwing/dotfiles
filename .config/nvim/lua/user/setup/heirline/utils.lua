local he_utils = require('heirline.utils')

local utils = require('user.utils')

local colors = require('user.setup.heirline.colors')

local M = {}

M.notify = require('user.utils').notify('Heirline Config')
M.notify_once = require('user.utils').notify_once('Heirline Config')

local function surroundf(component, sep)
  local lifted = {}

  -- everything that can update self before hl is called has to go here
  -- on_click should work over the extended component
  -- update and condition should apply to prevent errors and partially updated/shown components
  local tolift = { 'static', 'condition', 'update', 'init', 'on_click' }
  for _, comp in ipairs(tolift) do
    lifted[comp], component[comp] = component[comp], nil
  end

  local function swapped_hl(self)
    local hl = component.hl(self)
    if not hl then
      return hl
    end
    hl.fg, hl.bg = hl.bg, nil
    return hl
  end

  return vim.tbl_extend('error', lifted, {
    {
      hl = swapped_hl,
      provider = sep.left,
    },
    component,
    {
      hl = swapped_hl,
      provider = sep.right,
    },
  })
end

function M.component(name)
  return require('user.setup.heirline.components.' .. name)
end

--- Correctly surround a component with seperators, lifting out necessary parts to not leave empty seperators
--- @param component table|string the component to surround
--- @param sep string|{left: string|nil, right: string|nil} the seperators with wich to surround the component
--- @param color? string|number|false color or nil to disable
function M.surround(component, sep, color)
  vim.validate {
    component = { component, { 'table', 'string' } },
    sep = { sep, { 'table', 'string' } },
    color = { color, { 'string', 'number', 'boolean' }, true },
  }

  if type(component) == 'string' then
    component = M.component(component)
  end

  component = he_utils.clone(component)

  if type(sep) == 'string' then
    sep = { left = sep, right = sep }
  end

  if not (sep and (sep.left or sep.right)) then
    M.notify('utils.surround called without any seperators')
    return component
  end

  if not color and type(component.hl) == 'function' then
    return surroundf(component, sep)
  end

  if type(color) ~= 'boolean' then
    color = color or (component.hl and component.hl.bg) or colors.bg1
  else
    color = nil
  end

  -- lift condition out of component to apply to seperators as well
  local condition
  condition, component.condition = component.condition, nil

  return {
    condition = condition,
    {
      hl = color and { fg = color },
      provider = sep.left,
    },
    {
      hl = color and { bg = color },
      component,
    },
    {
      hl = color and { fg = color },
      provider = sep.right,
    },
  }
end

function M.disable_winbar(cond)
  return {
    condition = cond,
    init = function()
      vim.wo.winbar = nil
      -- Without redraw floating windows sometimes don't show up
      -- (e.g. diagnostic float, lsp hover)
      vim.defer_fn(function()
        vim.cmd.redraw { bang = true }
      end, 50)
    end,
  }
end

local function defer_internal(opts)
  local data = { cmd = {} }

  data.new_init, data.timer = utils.defer[opts.method](function()
    vim.api.nvim_exec_autocmds('User', { pattern = opts.names.user_pattern })
  end, opts.ms)

  data.group = vim.api.nvim_create_augroup(opts.names.group, { clear = true })
  data.cmd.enter = vim.api.nvim_create_autocmd(opts.events.bypass, {
    group = data.group,
    callback = function()
      vim.api.nvim_exec_autocmds('User', { pattern = opts.names.user_pattern })
    end,
  })
  data.cmd.update = vim.api.nvim_create_autocmd(opts.events.defer, {
    group = data.group,
    callback = function(args)
      if opts.callback then
        opts.callback(data.new_init, args)
      else
        data.new_init()
      end
    end,
  })
  -- cleanup
  data.cmd.cleanup = vim.api.nvim_create_autocmd('VimLeave', {
    group = data.group,
    callback = function()
      data.timer:stop()
      data.timer:close()
    end,
  })

  return data
end

--- create the necessary autocmds to defer component updates
---@param name string a unique string used to identify this component
---@param opts table
---@return table update a table to be passed to the update key of a component
---@return table static the data table containing autocmd ids etc for this component
function M.defer(name, opts)
  local methods = setmetatable({
    dl = 'debounce_leading',
    dt = 'debounce_trailing',
    tl = 'throttle_leading',
    tt = 'throttle_trailing',
  }, {
    __index = function(_, key)
      M.notify_once('utils.defer: tried to defer using unknown method: ' .. key)
    end,
  })

  local default_opts = {
    method = 'dt',
    ms = 500,
    events = {
      bypass = {},
      defer = {},
    },
    callback = nil,
  }
  opts = vim.tbl_deep_extend('force', default_opts, opts or {})
  opts.method = methods[opts.method]

  opts.names = {}
  opts.names.user_pattern = 'user_heirline_update_' .. name
  opts.names.group = opts.names.user_pattern .. '_group'

  local data = defer_internal(opts)

  return { 'User', pattern = opts.names.user_pattern }, { user_heirline_defer_data = data }
end

function M.defer_helper(component, name, opts)
  vim.validate { component = { component, 'table' } }

  local static, update = M.defer(name, opts)
  component = he_utils.clone(component, { static = static })
  component.update = update
  return component
end

return M
