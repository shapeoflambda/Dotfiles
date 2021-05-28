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

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp = require 'lspconfig'
            lsp.pyright.setup{}
            lsp.bashls.setup {}
            lsp.vimls.setup {}
            lsp.gopls.setup {}
            lsp.rust_analyzer.setup {}
            lsp.tsserver.setup {}
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
            keymaps = {
                noremap = true,
                buffer = true,
                ['n ]g'] = '<cmd>Gitsigns next_hunk<CR>',
                ['n [g'] = '<cmd>Gitsigns prev_hunk<CR>',
                ['n ,gu'] = '<cmd>Gitsigns reset_hunk<CR>',
            }
        }
    end
}

-- Tree-sitter
use 'nvim-treesitter/nvim-treesitter'
use 'nvim-treesitter/nvim-treesitter-textobjects'

use 'junegunn/fzf'
use 'junegunn/fzf.vim'

use 'folke/lsp-colors.nvim'
use 'ayu-theme/ayu-vim'
use 'shapeoflambda/dark-purple.vim'

-------------------- Status Line --------------------
use {
    'hoob3rt/lualine.nvim',
    config = function()
        require('lualine').setup{
            options = {
                theme = 'ayu_mirage',
                section_separators = {'', ''},
                component_separators = {'', ''},
                icons_enabled = true,
            },
            sections = {
                lualine_a = { {'mode', upper = true} },
                lualine_b = { {'filename', file_status = true} },
                lualine_c = { {'diagnostics', sources = {'nvim_lsp'}} },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { {'branch', icon = ''} },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {  },
                lualine_b = {  },
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {  },
                lualine_z = {   }
            },
            extensions = { 'fzf' }
        }
    end
}

use 'folke/tokyonight.nvim'
use 'kyazdani42/nvim-web-devicons'

-- Git
use 'tpope/vim-fugitive'

use 'hrsh7th/nvim-compe'

end)
