return {
  'stevearc/conform.nvim',

  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },

  keys = {
    {
      '<C-S-i>',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = { 'n', 'i' },
      desc = 'Format buffer',
    },
  },

  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt

      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end

      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      java = { 'google-java-format' },
      python = { 'black', 'isort' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      latex = { 'latexindent' },
      go = { 'gofumpt' },
    },
  },
}
