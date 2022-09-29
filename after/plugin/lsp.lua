local cmp = require('cmp')
local lspkind = require('lspkind')
local Remap = require('joshuajeschek.keymap')
local keymap = vim.keymap.set
local nnoremap = Remap.nnoremap
local tnoremap = Remap.tnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

require('lspsaga').init_lsp_saga({
    border_style = 'rounded',
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp_mapping = {
  ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { 'i', 's' }),

  ['<S-Tab>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    end
  end, { 'i', 's' }),
  ['<C-e>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}

local cmp_mapping_cmdline = cmp.mapping.preset.cmdline({
  -- override behavior so that cmp will be displayed if not yet visible
  ['<Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
  },
})

cmp.setup ({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
  mapping = cmp_mapping,
  formatting = {
    format = lspkind.cmp_format(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp_mapping_cmdline,
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp_mapping_cmdline,
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.jedi_language_server.setup{ capabilities = capabilities }

require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  -- settings for nvim configs
  settings = {
    Lua = {
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
-- floatterm
nnoremap('<C-ö>', '<cmd>Lspsaga open_floaterm<CR>', { silent = true } )
tnoremap('<C-ö>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- snippets
local snippets_paths = function()
  local plugins = { 'friendly-snippets' }
  local paths = {}
  local path
  local root_path = vim.env.HOME .. '/.vim/plugged/'
  for _, plug in ipairs(plugins) do
    path = root_path .. plug
    if vim.fn.isdirectory(path) ~= 0 then
      table.insert(paths, path)
    end
  end
  return paths
end

require('luasnip.loaders.from_vscode').lazy_load({
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = {},
})

