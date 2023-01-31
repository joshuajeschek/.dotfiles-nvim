local notify = require('notify')
vim.notify = notify
-- print = function(...)
--     local print_safe_args = {}
--     local _ = { ... }
--     for i = 1, #_ do
--         table.insert(print_safe_args, tostring(_[i]))
--     end
--     notify(table.concat(print_safe_args, ' '), "info")
-- end
notify.setup {
  stages = 'slide',
  background_colour = 'FloatShadow',
  timeout = 3000,
}
