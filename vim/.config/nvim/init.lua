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

-------------------- PLUGINS-------------------- 
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}

-- Editing
paq {'tpope/vim-surround'}
paq {'tpope/vim-unimpaired'}
paq {'tpope/vim-repeat'}
paq {'tpope/vim-commentary'}
paq {'SirVer/ultisnips'}
paq {'honza/vim-snippets'}

paq {'romainl/vim-cool'}

-- LSP
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/completion-nvim'}

-- tree sitter
paq {'nvim-treesitter/nvim-treesitter'}
paq {'nvim-treesitter/nvim-treesitter-textobjects'}

paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}

paq {'ayu-theme/ayu-vim'}

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

opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'wildmode', 'longest:full,full')
opt('o', 'wildoptions', '')
opt('o', 'laststatus', 1)

opt('o', 'completeopt', 'menuone,noinsert,noselect')

opt('o', 'termguicolors', true)
vim.api.nvim_command('let ayucolor="dark"')
vim.api.nvim_command('colorscheme ayu')
cmd 'au ColorScheme * lua vim.api.nvim_command("highlight Normal guibg=NONE")'

-------------------- MAPPINGS --------------------
map('n', '<C-p>', ':vnew<cr>')

map('n', ',f', '<cmd>Files<CR>')
map('n', ',F', '<cmd>GFiles<CR>')
map('n', ',rf', '<cmd>History<CR>')
map('n', ',b', '<cmd>Buffers<CR>')
map('n', ',e', '<cmd>Explore<CR>')

map('n', 'gy', '"+y')
map('x', 'gy', '"+y')
map('n', 'gp', '"+p')
map('n', 'gP', '"+P')
map('x', 'gp', '"+p')
map('x', 'gP', '"+P')

-------------------- TREE-SITTER --------------------
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

-------------------- LSP --------------------
local lsp = require 'lspconfig'

lsp.pyls_ms.setup {on_attach=require'completion'.on_attach}
lsp.bashls.setup {on_attach=require'completion'.on_attach}
lsp.vimls.setup {on_attach=require'completion'.on_attach}
lsp.gopls.setup {on_attach=require'completion'.on_attach}
lsp.rust_analyzer.setup {on_attach=require'completion'.on_attach}

vim.g.completion_enable_snippet = 'UltiSnips'

map('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', ',la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', ',lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', ',ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- Cusotom Text objects
map('x', 'il', ':<c-u>normal! g_v^<cr>')
map('o', 'il', ':<c-u>normal! g_v^<cr>')
map('x', 'al', ':<c-u>normal! $v0<cr>')
map('o', 'al', ':<c-u>normal! $v0<cr>')
map('x', 'id', ':<c-u>normal! G$Vgg0<cr>')
map('o', 'id', ':<c-u>normal! G$Vgg0<cr>')

-------------------- COMMANDS --------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {timeout = 300, on_visual = false}'

-- Ultisnip settings
vim.g.UltiSnipsSnippetDirectories  = {'UltiSnips', 'customsnippets'}
vim.g.UltiSnipsExpandTrigger       = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger  = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.UltiSnipsListSnippets        = '<C-s>'
vim.g.UltiSnipsEnableSnipMate      = 1
vim.g.UltiSnipsEditSplit           = 'vertical'
