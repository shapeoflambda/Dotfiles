local ok, _ = pcall(require, 'impatient')
if not ok then
    print('mdoule "impatient" not loaded')
else
    require'impatient'.enable_profile()
end

require('options')
require('mappings')


ok, _ = pcall(require, 'packer_compiled')
if not ok then
    print('mdoule "packer_compiled" not loaded')
end

vim.defer_fn(function()
    require("plugins")
end, 0)
