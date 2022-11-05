local util = require('formatter.util')
local Remap = require("joshuajeschek.keymap")
local Utils = require("joshuajeschek.utils")
local lines_from = Utils.lines_from
local file_exists = Utils.file_exists
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local TMPDIR = vim.fn.stdpath('data') .. '/formatter'
os.execute('mkdir -p' .. TMPDIR)
require('formatter').setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      -- require('formatter.filetypes.lua').luaformatter,
      function()
        return {
          exe = 'luaformatter',
          args = {
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
        }
      end
    },
    htmldjango = {
      function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, '\n')
        local tmpfile = TMPDIR .. '/' .. os.time()
        local f = io.open(tmpfile, 'w')
        if f == nil then
          return { exe = 'echo "Failed to create temp file"; (exit 1)' }
        end
        f:write(content)
        f:close()

        return {
          exe = 'djlint',
          args = {
            tmpfile,
            '--reformat',
            '--format-css',
            '--format-js',
            '--indent 2',
            '--preserve-blank-lines',
          },
          ignore_exitcode = true,
          no_append = true,
          stdin = false,
          transform = function(_)
            if not file_exists(tmpfile) then return lines end
            local flines = lines_from(tmpfile)
            os.execute('rm ' .. tmpfile)
            return flines
          end
        }
      end
    },
    haskell = {
      require('formatter.filetypes.haskell').stylish_haskell,
    },
    ["*"] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
}

nnoremap('<C-F>', ':w | :Format<CR>')
inoremap('<C-F>', '<C-o>:w | :Format<CR>')
