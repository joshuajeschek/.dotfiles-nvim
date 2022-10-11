local au = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup('joshuajeschek', { clear = true })

au('BufEnter', {
  pattern = {'*.md'},
  group = group,
  command = 'setlocal wrap'
})
