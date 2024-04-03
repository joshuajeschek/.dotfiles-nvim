local lines_from = require('joshuajeschek.utils').lines_from
local dir_file = vim.fn.stdpath('data') .. '/root_dirs.txt'

local function get_dirs()
  return lines_from(dir_file)
end

local function setup()
  require('nvim-rooter').setup({ manual = true })
  local group_id = vim.api.nvim_create_augroup('nvim_rooter', { clear = true })
  local au = vim.api.nvim_create_autocmd
  local home = os.getenv('HOME')
  local dirs = get_dirs()

  au('BufRead', {
    group = group_id,
    callback = function()
      vim.api.nvim_buf_set_var(0, 'root_dir', nil)
    end,
  })

  au('BufEnter', {
    group = group_id,
    nested = true,
    callback = function()
      require('nvim-rooter').rooter()
      local cwd = vim.fn.getcwd()
      if cwd ~= dirs[1] and cwd ~= home then
        local indices = {}
        for i, dir in pairs(dirs) do
          if cwd == dir then
            table.insert(indices, i)
          end
        end
        for _, i in pairs(indices) do
          table.remove(dirs, i)
        end
        table.insert(dirs, 1, cwd)
      end
    end,
  })

  au('ExitPre', {
    group = group_id,
    callback = function ()
      local f = io.open(dir_file, 'w')
      if f == nil then
        os.execute('touch ' .. dir_file)
        f = io.open(dir_file, 'w')
      end
      if f ~= nil then
        io.output(f)
        for i, dir in pairs(dirs) do
          if i > 9 then break end
          io.write(dir .. '\n')
        end
        io.close(f)
      end
    end
  })
end

return {
  setup = setup,
  get_dirs = get_dirs
}

