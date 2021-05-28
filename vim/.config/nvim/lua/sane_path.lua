local loop = vim.loop

local directories_to_ignore = {'build', 'node_modules', 'venv', '__pycache__'}

local M = {}

local function has_value (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local function should_include_in_path(directory)
  -- Ignore all hidden files
  if directory:find('^%.') ~= nil then
    return false
  end

  if has_value(directories_to_ignore, directory) then
    return false
  end

  return true
end

function M.set_path()
  local path = ","

  loop.fs_scandir(vim.fn.getcwd(), vim.schedule_wrap(function(err, fs)
    while true do
      local name, type = loop.fs_scandir_next(fs)
      if name == nil then
        break
      end

      if type == 'directory' and should_include_in_path(name) then
        path = path .. "," .. name .. "/**"
      end
    end

    vim.bo.path=path
  end))
end

return M
