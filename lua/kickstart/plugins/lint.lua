return {
  'mfussenegger/nvim-lint',

  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      -- lua = { 'luacheck' },
      -- python = { 'pylint' },
      -- javascript = { 'eslint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
