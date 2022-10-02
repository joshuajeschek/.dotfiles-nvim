local Remap = require('joshuajeschek.keymap')
local nnoremap = Remap.nnoremap
local tnoremap = Remap.tnoremap

require('lspsaga').init_lsp_saga({
    border_style = 'rounded',
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.jedi_language_server.setup{ capabilities = capabilities }

require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  -- settings for nvim configs
  settings = {
    Lua = {
      runtimes = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim', 'use'},
      },
      workspace = {
        libray = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.emmet_ls.setup{
  capabilites = capabilities
}

-- key bindings
nnoremap('<C-CR>', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
nnoremap('<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
nnoremap('<leader>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
nnoremap('<leader>?', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })
nnoremap('<leader>?', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })
nnoremap('<leader>ol', '<cmd>LSoutlineToggle<CR>', { silent = true })
nnoremap('<leader><leader>', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
-- floatterm
nnoremap('<C-ö>', '<cmd>Lspsaga open_floaterm<CR>', { silent = true } )
nnoremap('<C-ä>', '<cmd>Lspsaga open_floaterm lazygit<CR>', { silent = true } )
nnoremap('<C-ä>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true } )
tnoremap('<C-ö>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })


