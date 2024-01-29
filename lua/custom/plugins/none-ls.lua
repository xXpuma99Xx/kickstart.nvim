return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.black,
      },
    }
    vim.keymap.set('n', '<C-f>', vim.lsp.buf.format, { desc = 'Format document' })
  end,
}
