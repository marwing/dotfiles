local M = require('lualine.component'):extend()

function M:update_status()
  return [[%(%{&fenc . " " . WebDevIconsGetFileFormatSymbol()}%)]]
end

return M
