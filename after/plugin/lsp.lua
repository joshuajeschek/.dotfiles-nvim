local Remap = require('joshuajeschek.keymap')
local nnoremap = Remap.nnoremap
local tnoremap = Remap.tnoremap

require('lspsaga').init_lsp_saga({
  border_style = 'rounded',
  code_action_icon = '',
  code_action_lightbulb = {enable_in_insert = false},
  symbol_in_winbar = {
    -- separator = '  ',
    separator = ' ',
    enable = true,
    show_file = true,
    file_formatter = '%',
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.jedi_language_server.setup {capabilities = capabilities}
require'lspconfig'.hls.setup {capabilities = capabilities}
require'lspconfig'.texlab.setup {capabilities = capabilities}

require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  -- settings for nvim configs
  settings = {
    Lua = {
      runtimes = {version = 'LuaJIT'},
      diagnostics = {globals = {'vim', 'use'}},
      workspace = {libray = vim.api.nvim_get_runtime_file('', true)},
      telemetry = {enable = false}
    }
  }
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  filetypes = {'html', 'htmldjango'}
}

require'lspconfig'.emmet_ls.setup {
  capabilities = capabilities,
  filetypes = {
    'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less',
    'htmldjango'
  }
}
require'lspconfig'.tsserver.setup {capabilities = capabilities}

-- key bindings
nnoremap('<C-CR>', '<cmd>Lspsaga lsp_finder<CR>', {silent = true})
nnoremap('<leader>ca', '<cmd>Lspsaga code_action<CR>', {silent = true})
nnoremap('<leader>rn', '<cmd>Lspsaga rename<CR>', {silent = true})
nnoremap('<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>', {silent = true})
nnoremap('<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {silent = true})
nnoremap('<leader>ol', '<cmd>LSoutlineToggle<CR>', {silent = true})
nnoremap('<leader><leader>', '<cmd>Lspsaga hover_doc<CR>', {silent = true})
-- floatterm
nnoremap('<C-ö>', '<cmd>Lspsaga open_floaterm<CR>', {silent = true})
nnoremap('<C-ä>', '<cmd>Lspsaga open_floaterm lazygit<CR>', {silent = true})
nnoremap('<C-ä>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
         {silent = true})
tnoremap('<C-ö>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
         {silent = true})
