local Utils = require'joshuajeschek.utils'
require'mini.trailspace'.setup()
require'mini.comment'.setup()
require'mini.surround'.setup()
require'mini.cursorword'.setup()
require'mini.indentscope'.setup()

local starter = require('mini.starter')
local home = os.getenv('HOME')
local user_host = os.getenv('USER')
  .. '@' .. io.popen('/bin/hostname'):read('*a'):gsub('\n', '')
         .. io.popen('cat /etc/hostname'):read('*a'):gsub('\n', '')

local starter_items = {
  {
    name = 'Find Files',
    action = Utils.git_find,
    section = '',
  },
  {
    name = 'Live Grep',
    action = 'Telescope live_grep',
    section = '',
  },
}

table.insert(starter_items, starter.sections.recent_files(5, true))

for _, dir in pairs(require('joshuajeschek.dirs').get_dirs()) do
  local name = dir:match('[^/]*$') .. ' (' .. dir:gsub(home, '~') .. ')'
  table.insert(starter_items, {
    name = name,
    action = 'cd ' .. dir .. ' | lua MiniStarter.refresh()',
    section = 'Recent directories'
  })
end

table.insert(starter_items, {
  name = 'Update Plugins',
  action = 'PackerSync',
  section = '---'
})
table.insert(starter_items, {
  name = 'Mason',
  action = 'Mason',
  section = '---'
})
table.insert(starter_items, {
  name = 'Configure Nvim',
  action = 'Telescope find_files hidden=true cwd=' .. home .. '/.config/nvim',
  section = '---'
})
table.insert(starter_items, {
  name = 'Dotfiles',
  action = 'Telescope find_files hidden=true cwd=' .. home,
  section = '---'
})

starter.setup({
  header = function ()
    return [[
███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝

░ ]] .. os.date() .. '\n░ ' .. user_host .. '\n░ ' .. vim.fn.getcwd()
  end
  ,
  items = starter_items,
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789.-_',
  footer = '\n░ Time spent coding today: ...'
})

vim.defer_fn(function()
  local wakatime = io.popen('~/.wakatime/wakatime-cli --today'):read('*a')
  MiniStarter.config.footer = '\n░ Time spent coding today: ' .. wakatime
    MiniStarter.config.items[#MiniStarter.config.items] = {
      name = 'Dotfiles',
      action = 'lua require("joshuajeschek.utils").find_dotfiles()',
      section = '---'
    }
  if vim.api.nvim_buf_get_option(0, 'filetype') == 'starter' then
    MiniStarter.refresh()
  end
end, 0)

