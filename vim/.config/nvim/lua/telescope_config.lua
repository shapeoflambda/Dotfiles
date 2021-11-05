local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

local mappings = {
    i = {
        ["<C-h>"] = "which_key",
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-q>"] = trouble.open_with_trouble,
    },
    n = {
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-q>"] = trouble.open_with_trouble,
        ["<C-h>"] = "which_key",
    }
}

local custom_ivy_opts = require('telescope.themes').get_ivy {
    border = true,
    prompt_prefix = "ﮂ ",
    selection_caret = "▊ ",
    layout_config = {
        height = 18,
    },
    mappings = mappings,
}
local cursor_opts = require('telescope.themes').get_cursor {
    results_title = false,
    layout_config = {
        width = 0.4,
        height = 0.3,
    },
}

require('telescope').setup {
    defaults = custom_ivy_opts,
    pickers = {
        buffers = {
            prompt_title = '✨ Search Buffers ✨',
            mappings = vim.tbl_deep_extend('force', {
                n = {
                    ['d'] = actions.delete_buffer,
                    ['D'] = actions.delete_buffer,
                },
            }, mappings),
            sort_mru = true,
            preview_title = false,
        },
        find_files = vim.tbl_deep_extend('force', custom_ivy_opts, {
            prompt_title = ' Find Files',
            preview_title = false,
        }),
        oldfiles = vim.tbl_deep_extend('force', custom_ivy_opts, {
            prompt_title = ' Recently Opened',
            preview_title = false,
            path_display = function(_, path)
              return vim.fn.fnamemodify(path, ':s?/Volumes/workplace/.\\{-}/src/?#/?:~:.')
            end,
        }),
        lsp_code_actions = vim.tbl_deep_extend('force', cursor_opts, {
            prompt_title = ' Code Actions',
        }),
        lsp_range_code_actions = vim.tbl_deep_extend('force', cursor_opts, {
            prompt_title = ' Code Actions',
        }),
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

-- Telescope Mappings
local function map(mode, lhs, rhs, opts)
    local options = {silent = true, noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", ",F", "<cmd>Telescope find_files<CR>")
map("n", ",gf", "<cmd>Telescope git_files<CR>")
map("n", ",b", "<cmd>Telescope buffers<CR>")
map("n", ",rf", "<cmd>Telescope oldfiles<CR>")
map("n", ",v", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>")
map("n", ",h", "<cmd>Telescope help_tags<CR>")
map("n", ",rg", "<cmd>Telescope live_grep<CR>")
map("n", ",gv", "<cmd>Telescope live_grep cwd=~/.config/nvim<CR>")
map("n", "<M-x>", "<cmd>Telescope<CR>")

map('n', ',@', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', ',ld', '<cmd>Telescope lsp_document_diagnostics<CR>')
map('n', ',lg', '<cmd>Telescope lsp_definitions<CR>')
map('n', ',lr', '<cmd>Telescope lsp_references<CR>')

-- Extensions
local extensions = {'fzf'}
for _, extension in ipairs(extensions) do
    require('telescope').load_extension(extension)
end

