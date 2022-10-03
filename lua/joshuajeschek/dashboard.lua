local db = require('dashboard')
local nnoremap = require('joshuajeschek.keymap').nnoremap
local rpad = require('joshuajeschek.utils').rpad
local home = os.getenv('HOME')

local cmd = io.popen('dotbare ls-tree -r main --name-only         tr "\n" ","')
local dotfiles = ' '
if cmd ~= nil then
  dotfiles = cmd:read('*a'):gsub('%,\n', '')
end
local dotfiles_action = 'Telescope find_files hidden=true cwd=' .. home
if not string.find(dotfiles, ' ') then
  dotfiles_action = dotfiles_action .. ' search_dirs=' .. dotfiles
end

local dirs = require('joshuajeschek.dirs').get_dirs()

db.custom_header = function ()
    return {
  '',
  '███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗',
  '████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║',
  '██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║',
  '██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║',
  '██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║',
  '╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝',
  '',
  vim.fn.getcwd()
}
end
db.custom_center = {
  {
    icon = '  ',
    desc = 'Find Files',
    action = 'Telescope find_files',
    shortcut = 'SPC F F'
  },
  {
    icon = '  ',
    desc = 'Live Grep',
    action = 'Telescope live_grep',
    shortcut = 'SPC L G'
  },
  {
    icon = 'ﮮ  ' ,
    desc = 'Oldfiles',
    action = 'Telescope oldfiles',
    shortcut = 'SPC O F'
  },
  {
    icon = '痢 ',
    desc = 'Update Plugins',
    action = 'PackerSync',
    shortcut = '       '
  },
  {
    icon = '  ',
    desc = 'Edit Nvim Config',
    action = 'Telescope find_files cwd=' .. home .. '/.config/nvim hidden=true',
    shortcut = '       '
  },
  {
    icon = '  ',
    desc = 'Edit Dotfiles',
    action = dotfiles_action,
    shortcut = '       '
  },
}
db.hide_statusline = false
db.header_pad = 3
db.center_pad = 3
db.footer_pad = 3

local max_desc_len = 0

for i, dir in pairs(dirs) do
  table.insert(db.custom_center, {
    icon = 'ﮛ  ',
    desc = dir:gsub(home, '~'),
    action = 'cd ' .. dir,
    shortcut = '  ALT ' .. i
  })
  nnoremap('<A-' .. i .. '>', ':cd ' .. dir .. '<CR>')
end

for _, c in pairs(db.custom_center) do
  if #c.desc > max_desc_len then
    max_desc_len = #c.desc
  end
end
for _, c in pairs(db.custom_center) do
  c.desc = rpad(c.desc, max_desc_len + 1)
end

