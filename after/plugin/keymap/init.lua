local Remap = require('joshuajeschek.keymap')
local Utils = require('joshuajeschek.utils')

local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
-- local vnoremap = Remap.vnoremap

-- lsp keybinds -> lsp.lua
-- cmp keybinds -> cmp.lua
-- formatter keybinds -> formatter.lua

nnoremap('<leader>db', function ()
    MiniStarter.open()
    MiniStarter.refresh()
end)

-- telescope
nnoremap('<leader>t', ':Telescope<CR>')
nnoremap('<leader>tr', ':Telescope resume<CR>')
nnoremap('<leader>fb', ':Telescope file_browser<CR>')
nnoremap('<leader>ff', Utils.git_find)
nnoremap('<leader>fg', ':Telescope git_files<CR>')
nnoremap('<leader>of', ':Telescope oldfiles<CR>')
nnoremap('<leader>lg', ':Telescope live_grep<CR>')

-- commenting
inoremap('<C-#>', '<C-o>:lua MiniComment.operator("line")<CR>')

-- undo/ redo
nnoremap('<C-z>', 'u')
nnoremap('<C-S-z>', 'C-r')
inoremap('<C-z>', '<C-o>u')
inoremap('<C-S-z>', '<C-o><C-r>')
inoremap('<C-l>', 'λ')

-- copilot
inoremap('<C-Enter>', 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false})
inoremap('<C-n>', 'copilot#Next()', { silent = true, expr = true })
inoremap('<C-S-n>', 'copilot#Previous()', { silent = true, expr = true })
