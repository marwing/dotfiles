-- This code is a slightly shortened version of
-- https://github.com/runiq/neovim-throttle-debounce/blob/b9e2f0acc55f6d25790636beeb8e99230b60b081/defer.lua
-- which falls under the MIT License

--[[ https://github.com/runiq/neovim-throttle-debounce/blob/b9e2f0acc55f6d25790636beeb8e99230b60b081/LICENSE
MIT License

Copyright (c) 2022 runiq

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local M = {}

---Validates args for `throttle()` and  `debounce()`.
local function td_validate(fn, ms)
  vim.validate {
    fn = { fn, 'f' },
    ms = {
      ms,
      function(ms)
        return type(ms) == 'number' and ms > 0
      end,
      'number > 0',
    },
  }
end

--- Throttles a function on the leading edge. Automatically `schedule_wrap()`s.
---
--@param fn (function) Function to throttle
--@param timeout (number) Timeout in ms
--@returns (function, timer) throttled function and timer. Remember to call
---`timer:close()` at the end or you will leak memory!
function M.throttle_leading(fn, ms)
  td_validate(fn, ms)
  local timer = vim.loop.new_timer()
  local running = false

  local function wrapped_fn(...)
    if not running then
      timer:start(ms, 0, function()
        running = false
      end)
      running = true
      pcall(vim.schedule_wrap(fn), select(1, ...))
    end
  end
  return wrapped_fn, timer
end

--- Throttles a function on the trailing edge. Automatically
--- `schedule_wrap()`s.
---
--@param fn (function) Function to throttle
--@param timeout (number) Timeout in ms
--@param last (boolean, optional) Whether to use the arguments of the last
---call to `fn` within the timeframe. Default: Use arguments of the first call.
--@returns (function, timer) Throttled function and timer. Remember to call
---`timer:close()` at the end or you will leak memory!
function M.throttle_trailing(fn, ms, last)
  td_validate(fn, ms)
  local timer = vim.loop.new_timer()
  local running = false

  local wrapped_fn
  if not last then
    function wrapped_fn(...)
      if not running then
        local argv = { ... }
        local argc = select('#', ...)

        timer:start(ms, 0, function()
          running = false
          pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
        end)
        running = true
      end
    end
  else
    local argv, argc
    function wrapped_fn(...)
      argv = { ... }
      argc = select('#', ...)

      if not running then
        timer:start(ms, 0, function()
          running = false
          pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
        end)
        running = true
      end
    end
  end
  return wrapped_fn, timer
end

--- Debounces a function on the leading edge. Automatically `schedule_wrap()`s.
---
--@param fn (function) Function to debounce
--@param timeout (number) Timeout in ms
--@returns (function, timer) Debounced function and timer. Remember to call
---`timer:close()` at the end or you will leak memory!
function M.debounce_leading(fn, ms)
  td_validate(fn, ms)
  local timer = vim.loop.new_timer()
  local running = false

  local function wrapped_fn(...)
    timer:start(ms, 0, function()
      running = false
    end)

    if not running then
      running = true
      pcall(vim.schedule_wrap(fn), select(1, ...))
    end
  end
  return wrapped_fn, timer
end

--- Debounces a function on the trailing edge. Automatically
--- `schedule_wrap()`s.
---
--@param fn (function) Function to debounce
--@param timeout (number) Timeout in ms
--@param first (boolean, optional) Whether to use the arguments of the first
---call to `fn` within the timeframe. Default: Use arguments of the last call.
--@returns (function, timer) Debounced function and timer. Remember to call
---`timer:close()` at the end or you will leak memory!
function M.debounce_trailing(fn, ms, first)
  td_validate(fn, ms)
  local timer = vim.loop.new_timer()
  local wrapped_fn

  if not first then
    function wrapped_fn(...)
      local argv = { ... }
      local argc = select('#', ...)

      timer:start(ms, 0, function()
        pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
      end)
    end
  else
    local argv, argc
    function wrapped_fn(...)
      argv = argv or { ... }
      argc = argc or select('#', ...)

      timer:start(ms, 0, function()
        pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
      end)
    end
  end
  return wrapped_fn, timer
end

return M
