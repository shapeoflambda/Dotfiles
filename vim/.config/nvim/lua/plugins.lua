return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Editing
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    use 'romainl/vim-cool'

    use 'ray-x/lsp_signature.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    use {
        'glepnir/lspsaga.nvim',
        config = function()
            local saga = require 'lspsaga'
            saga.init_lsp_saga()
        end
    }

    use {
        'folke/trouble.nvim',
        config = function()
            require("trouble").setup {
                action_keys = { -- key mappings for actions in the trouble list
                    close = "q", -- close the list
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    refresh = "r", -- manually refresh
                    jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
                    jump_close = {"o"}, -- jump to the diagnostic and close the list
                    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                    toggle_preview = "P", -- toggle auto_preview
                    hover = "K", -- opens a small poup with the full multiline message
                    preview = "p", -- preview the diagnostic location
                    close_folds = {"zM", "zm"}, -- close all folds
                    open_folds = {"zR", "zr"}, -- open all folds
                    toggle_fold = {"zA", "za"}, -- toggle fold of current file
                    previous = "[q", -- preview item
                    next = "]q" -- next item
            }
        }
    end
}

use {
    'folke/which-key.nvim',
    config = function()
        require("which-key").setup {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 20
                }
            }
        }
    end
}

use {
    'lewis6991/gitsigns.nvim',
    requires = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('gitsigns').setup{
            signs = {
                add = {text = "▎"},
                change = {text = "▎"},
                delete = {text = "▎"},
                topdelete = {text = "▎"},
                changedelete = {text = "▎"}
            },
            keymaps = {
                noremap = true,
                buffer = true,
                ['n ]g'] = '<cmd>Gitsigns next_hunk<CR>',
                ['n [g'] = '<cmd>Gitsigns prev_hunk<CR>',
                ['n ,gu'] = '<cmd>Gitsigns reset_hunk<CR>',
                ['n ,gp'] = '<cmd>Gitsigns preview_hunk<CR>',
                ['n ,ga'] = '<cmd>Gitsigns stage_hunk<CR>',
            }
        }
    end
}

-- Tree-sitter
use 'nvim-treesitter/nvim-treesitter'
use 'nvim-treesitter/nvim-treesitter-textobjects'

use 'junegunn/fzf'
use 'junegunn/fzf.vim'
use 'gfanto/fzf-lsp.nvim'

-- Telescope
use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

-- Smooth scroll
use {
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup()
    end
}

use 'folke/lsp-colors.nvim'
use 'Shatur/neovim-ayu'
use 'Mofiqul/dracula.nvim'
use 'ful1e5/onedark.nvim'
use 'shaunsingh/nord.nvim'
use {
    'https://gitlab.com/__tpb/monokai-pro.nvim',
    config = function()
        vim.g.monokaipro_filter = "spectrum"
        vim.g.monokaipro_italic_functions = true
        vim.g.monokaipro_sidebars = { "vista_kind", "packer" }
        vim.g.monokaipro_flat_term = true

        -- Change the "hint" color to the "orange" color, and make the "error" color bright red
        vim.g.monokaipro_colors = { hint = "orange", error = "#ff0000" }

        -- Load the colorscheme
        vim.cmd[[colorscheme monokaipro]]
    end
}

use 'folke/tokyonight.nvim'
use 'kyazdani42/nvim-web-devicons'

-- Git
use 'tpope/vim-fugitive'

use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/nvim-cmp'
use 'quangnguyen30192/cmp-nvim-ultisnips'
use 'onsails/lspkind-nvim'

use { -- A minimal, stylish and customizable statusline for Neovim written in Lua
'Famiu/feline.nvim',
requires = {
    'nvim-lua/lsp-status.nvim',
},
config = [[ require('statusline') ]],
                                                  }

end)
