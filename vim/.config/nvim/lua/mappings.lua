-------------------- MAPPINGS --------------------

local function map(mode, lhs, rhs, opts)
    local options = {silent = true, noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-p>', ':vnew<cr>')
map('n', '<Space>pp', ':PackerSync<cr>')

map('n', ',f', ':find *')
map('n', ',e', '<cmd>Explore<CR>')

map('n', ',@', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', ',E', '<cmd>Telescope file_browser<CR>')

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

map('v', '.', ':norm .<CR>')
map('v', 'Q', ':norm @q<CR>')
map('v', '+', 'g<C-a>')
map('v', '-', 'g<C-x>')

map('n', '<M-`>', '<C-^>')
map('n', '<C-s>', '<C-^>')
