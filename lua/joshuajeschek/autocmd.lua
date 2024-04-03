local au = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup('joshuajeschek', { clear = true })

au('BufEnter', {
  pattern = {'*.md', '*.tex'},
  group = group,
  command = 'setlocal wrap linebreak'
})

au('BufEnter', {
  pattern = {'*.tex'},
  group = group,
  command = 'setlocal tw=100'
})
