-------------------- OPTIONS --------------------
local cmd = vim.cmd

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'hidden', true)

local indent = 2
opt('b', 'shiftwidth', indent)
opt('b', 'tabstop', indent)
opt('b', 'expandtab', true)
opt('b', 'smartindent', true)

opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'wrapscan', false)
opt('o', 'scrolloff', 3)

opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'wildmode', 'longest:full,full')
opt('o', 'wildoptions', '')
opt('o', 'laststatus', 2)
opt('w', 'cursorline', true)

opt('o', 'completeopt', 'menuone,noinsert,noselect')
opt('o', 'fillchars', 'diff: ')
opt('o', 'inccommand', "nosplit")
opt('o', 'wildignore', '*.pyc')
opt('o', 'showmode', false)

-------------------- PERSISTENT UNDO --------------------
if vim.fn.has('persistent_undo') == 1 then
    opt('o', 'undofile', true)
    vim.api.nvim_command('set undodir^=~/.config/nvim/cache/undo//')
end

-------------------- COMMANDS --------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout = 300}'
cmd 'au BufEnter * lua require("sane_path").set_path()'

vim.g.did_load_filetypes = 1

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "logipat",
    "matchit",
    "netrwFileHandlers",
    "netrwSettings",
    "rrhelper",
    "spellfile_plugin",
    "tar",
    "tarPlugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Improved Diffing
vim.cmd[[set diffopt=filler,internal,algorithm:histogram,indent-heuristic]]
