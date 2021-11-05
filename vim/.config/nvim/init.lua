vim.opt.shadafile = "NONE"

require('options')
require('colorscheme')
require('mappings')

vim.defer_fn(function()
  require("plugins")
end, 0)

vim.opt.shadafile = ""
