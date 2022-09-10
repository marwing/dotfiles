local M = {}

M.notify = function(title, default_level)
  title = title or 'notify_once helper'
  default_level = default_level or vim.log.levels.WARN

  return function(msg, level, opts)
    opts = opts or {}
    opts.title = opts.title or title
    level = level or default_level

    vim.notify(msg, level, opts)
  end
end

M.notify_once = function(title, default_level)
  title = title or 'notify_once helper'
  default_level = default_level or vim.log.levels.WARN

  return function(msg, level, opts)
    opts = opts or {}
    opts.title = opts.title or title
    level = level or default_level

    vim.notify_once(msg, level, opts)
  end
end

return M
