local M = {}

function new_function(args)
    
end

function M.setup()
    local snap = require'snap'

    local function create(config)
        return snap.create(config, {
            reverse = true,
            layout = snap.get"layout".top,
            mappings = {
                enter = {"<CR>", "<C-o>"},
            }
        })
    end

    snap.register.map('n', ',F', create(function ()
        return {
            producer = snap.get'consumer.fzy'(snap.get'producer.ripgrep.file'),
            args = {'--hidden', '--iglob', '!.git/*'},
            select = snap.get'select.file'.select,
            multiselect = snap.get'select.file'.multiselect,
            reverse = true,
            layout = snap.get"layout".top,
            views = {snap.get'preview.file'},
            prompt = " "
        }
    end))

    snap.register.map('n', ',G', create(function ()
        return {
            producer = snap.get'producer.ripgrep.vimgrep',
            select = snap.get'select.vimgrep'.select,
            multiselect = snap.get'select.vimgrep'.multiselect,
            views = {snap.get'preview.vimgrep'},
            prompt = " ⚡"
        }
    end))

    snap.register.map('n', ',v', create(function ()
        return {
            producer = snap.get'consumer.fzy'(
            snap.get'consumer.combine'(
            snap.get'producer.ripgrep.file'.args({}, "/Users/chndha/.config/nvim")
            )
            ),
            select = snap.get'select.file'.select,
            multiselect = snap.get'select.file'.multiselect,
            views = {snap.get'preview.file'},
            prompt = " "
        }
    end))

    snap.register.map('n', ',rf', create(function ()
        return {
            producer = snap.get'consumer.fzy'(snap.get'producer.vim.oldfile'),
            select = snap.get'select.file'.select,
            multiselect = snap.get'select.file'.multiselect,
            views = {snap.get'preview.file'},
            prompt = " ⛬"
        }
    end))

    snap.register.map('n', ',b', create(function ()
        return {
            producer = snap.get'consumer.fzy'(snap.get'producer.vim.buffer'),
            select = snap.get'select.file'.select,
            multiselect = snap.get'select.file'.multiselect,
            views = {snap.get'preview.file'},
            prompt = "Buffers ✍"
        }
    end))

    
    vim.cmd([[
        augroup Snap
        autocmd!
        autocmd ColorScheme * lua vim.cmd('highlight link SnapSelect TelescopeSelection')
        augroup END
    ]])
    -- vim.cmd('highlight link SnapSelect TelescopeSelection')
end

return M

