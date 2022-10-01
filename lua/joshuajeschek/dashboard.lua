local db = require('dashboard')
local home = os.getenv('HOME')

local cmd = io.popen('dotbare ls-tree -r main --name-only | tr "\n" ","')
local dotfiles = ' '
if cmd ~= nil then
  dotfiles = cmd:read('*a'):gsub('%,\n', '')
end
local dotfiles_action = 'Telescope find_files hidden=true cwd=' .. home
if not string.find(dotfiles, ' ') then
  dotfiles_action = dotfiles_action .. ' search_dirs=' .. dotfiles
end

db.custom_header = {
  '',
  '███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗',
  '████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║',
  '██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║',
  '██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║',
  '██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║',
  '╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝',
  '',
}
db.custom_center = {
  {
    icon = '  ',
    desc = 'Find Files           ',
    action = 'Telescope find_files',
    shortcut = '|'
  },
  {
    icon = '  ',
    desc = 'Find Word            ',
    action = 'Telescope live_grep',
    shortcut = '|'
  },
  {
    icon = '痢 ',
    desc = 'Recently Opened Files',
    action = 'Telescope oldfiles',
    shortcut = '|'
  },
  {
    icon = '痢 ',
    desc = 'Update Plugins       ',
    action = 'PackerSync',
    shortcut = '|'
  },
  {
    icon = '  ',
    desc = 'Edit Nvim Config     ',
    action = 'Telescope find_files cwd=' .. home .. '/.config/nvim hidden=true',
    shortcut = '|'
  },
  {
    icon = '  ',
    desc = 'Edit Dotfiles        ',
    action = dotfiles_action,
    shortcut = '|'
  },
}
db.hide_statusline = false
