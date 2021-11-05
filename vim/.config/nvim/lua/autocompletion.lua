  local cmp = require'cmp'
  local lspkind = require('lspkind')

  local has_any_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local press = function(key)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
          if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
              press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
          elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
              press("<ESC>:call UltiSnips#JumpForwards()<CR>")
          elseif cmp.visible() then
              cmp.select_next_item()
          elseif has_any_words_before() then
              press("<Tab>")
          else
              fallback()
          end
      end, {"i","s"}),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
          if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
              press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
          elseif cmp.visible() then
              cmp.select_prev_item()
          else
              fallback()
          end
      end, {"i","s"}),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'buffer' },
    },
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
  })
