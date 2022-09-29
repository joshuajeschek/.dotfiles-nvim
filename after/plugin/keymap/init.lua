local Remap = require("joshuajeschek.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

-- telescope
nnoremap("<C-p>", function()
  require('telescope.builtin').find_files()
end)
nnoremap("<C-A-p>", ":Telescope<CR>")
nnoremap("<space>fb", ":Telescope file_browser<CR>")


-- undo/ redo
nnoremap("<C-z>", "u")
nnoremap("<C-S-z>", "C-r")
inoremap("<C-z>", "<C-o>u")
inoremap("<C-S-z>", "<C-o><C-r>")

-- Neoformat
nnoremap("<C-S-G>", ":Neoformat<CR>")
inoremap("<C-S-G>", "<C-o>:Neoformat<CR>")

-- rename objects
inoremap('<F2>', '<cmd>lua require("renamer").rename()<cr>', { silent = true })
nnoremap('<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { silent = true })
vnoremap('<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { silent = true })

