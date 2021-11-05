-- LSP Settings
local nvim_lsp = require 'lspconfig'

local function map(mode, lhs, rhs, opts)
    local options = {silent = true, noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local on_attach = function(client, _)
    map('n', ',la', '<cmd>Telescope lsp_code_actions<CR>')
    map('n', ',ca', '<cmd>Telescope lsp_code_actions<CR>')
    map('v', ',ca', ':<C-U>Telescope lsp_range_code_actions<CR>')
    map('v', ',la', ':<C-U>Telescope lsp_range_code_actions<CR>')
    map('n', ',lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n', 'gr',  '<cmd>Telescope lsp_references<CR>')
    map('n', ',ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n', 'K',   '<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n', 'gs',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('i', '<C-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n', 'gR',  '<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n', 'gD',  '<cmd>Telescope lsp_definitions<CR>')
    map('n', 'gd',  '<cmd>Telescope lsp_definitions<CR>')
    map('n', '[e',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    map('n', ']e',  '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')

    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Enable the following language servers
local servers = { 'bashls', 'vimls', 'gopls', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/Users/chndha/.local/bin/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    cmd = {sumneko_binary},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      telemetry = {
        enable = false,
      },
    },
  },
})

nvim_lsp.sumneko_lua.setup(luadev)


local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.prettier.with({
        filetypes = { "html", "json", "yaml", "markdown" },
    }),
    null_ls.builtins.formatting.black.with({
        filetypes = { "python" },
    }),
    null_ls.builtins.formatting.isort.with({
        filetypes = { "python" },
    }),
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci" }
    }),
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns,
}

null_ls.config({ sources = sources })

nvim_lsp["null-ls"].setup({
    on_attach = on_attach
})


vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single'
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
})
