-------------------- HELPERS --------------------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
    local options = {silent = true, noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Install packer if not installed already
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

-------------------- Plugins --------------------
require('plugins')
require('snap_config').setup()

-------------------- OPTIONS --------------------
opt('o', 'hidden', true)
opt('o', 'ruler', true)

local indent = 2
opt('b', 'shiftwidth', indent)
opt('b', 'tabstop', indent)
opt('b', 'expandtab', true)
opt('b', 'autoindent', true)
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

-------------------- MAPPINGS --------------------
map('n', '<C-p>', ':vnew<cr>')

map('n', ',f', ':find *')
map('n', ',e', '<cmd>Explore<CR>')

map('n', ',@', '<cmd>Telescope lsp_document_symbols<CR>')
-- map('n', ',E', '<cmd>Telescope file_browser<CR>')
-- map('n', ',F', '<cmd>Telescope find_files<CR>')
-- map('n', ',b', '<cmd>Telescope buffers<CR>')
map('n', ',h', '<cmd>Telescope help_tags<CR>')
-- map('n', ',rf', '<cmd>Telescope oldfiles<CR>')

map('n', ',B', '<Cmd>BOnly<cr>')
map('n', 'gy', '"+y')
map('x', 'gy', '"+y')
map('n', 'gp', '"+p')
map('n', 'gP', '"+P')
map('x', 'gp', '"+p')
map('x', 'gP', '"+P')

map('x', '<', '<gv')
map('x', '>', '>gv')

map('n', '<C-l>', '<Cmd>TroubleToggle<CR>')
map('n', ',d', '<Cmd>Trouble lsp_document_diagnostics<CR>')

map('n', ',gd', '<Cmd>Gvdiffsplit<CR>')
map('n', '<Space>gg', '<Cmd>Git<CR>')

---------------------- TREE-SITTER --------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ii"] = "@conditional.inner",
                ["ai"] = "@conditional.outer",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["]a"] = "@parameter.inner",
            },
            swap_previous = {
                ["[a"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        }
    },
}

map('n', ',la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', ',lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', ',ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
map('n', 'gs', '<cmd>Lspsaga signature_help<CR>')
map('n', 'gR', '<cmd>Lspsaga rename<CR>')
map('n', 'gD', '<cmd>Lspsaga preview_definition<CR>')
map('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>')
map('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>')

map('n', ',ca', '<cmd>Lspsaga code_action<CR>')
map('v', ',ca', ':<C-U>Lspsaga range_code_action<CR>')
-------------------- COMMANDS --------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {timeout = 300, on_visual = false}'
cmd 'au BufEnter * lua require("sane_path").set_path()'

-- Ultisnip settings
vim.g.UltiSnipsSnippetDirectories  = {'UltiSnips', 'customsnippets'}
vim.g.UltiSnipsExpandTrigger       = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger  = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.UltiSnipsListSnippets        = '<C-s>'
vim.g.UltiSnipsEnableSnipMate      = 1
vim.g.UltiSnipsEditSplit           = 'vertical'

-------------------- COLORSCHEME --------------------
opt('o', 'termguicolors', true)
vim.api.nvim_command('let ayucolor="mirage"')
vim.g.tokyonight_style = "night"
vim.api.nvim_command('colorscheme monokaipro')
-- require('nord').set()

-- cmd 'au ColorScheme * lua vim.api.nvim_command("highlight Normal guibg=NONE")'
-- cmd 'au ColorScheme * lua vim.api.nvim_command("highlight NormalFloat guibg=#393f54")'
-- cmd 'au ColorScheme * lua vim.api.nvim_command("highlight Comment gui=italic")'

-------------------- PERSISTENT UNDO --------------------
if vim.fn.has('persistent_undo') == 1 then
    opt('o', 'undofile', true)
    vim.api.nvim_command('set undodir^=~/.config/nvim/cache/undo//')
end

-------------------- Autocompletion --------------------
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
    };
}
