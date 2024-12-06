local M = {}

function M.is_wsl()
  if vim.fn.has("unix") == 1 then
    local lines = vim.fn.readfile("/proc/version")
    if string.find(lines[1], "WSL") then
      return true
    end
  end
  return false
end

return M
