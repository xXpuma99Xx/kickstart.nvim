return {
  'lukas-reineke/indent-blankline.nvim',

  dependencies = { 'HiPhish/rainbow-delimiters.nvim' },

  main = 'ibl',
  opts = {},

  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    local highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    }

    vim.g.rainbow_delimiters = vim.tbl_extend('force', vim.g.rainbow_delimiters or {}, {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = highlight,
    })

    vim.api.nvim_set_hl(0, 'IndentGuides', { fg = '#555555', nocombine = true })

    require('ibl').setup {
      scope = {
        highlight = highlight,
        show_start = true,
        show_end = true,
        enabled = true,
        char = '┆',
        show_exact_scope = true,
        injected_languages = true,
      },
      indent = {
        char = '┆',
        highlight = { 'IndentGuides' },
      },
      whitespace = {
        highlight = { 'Whitespace' },
        remove_blankline_trail = true,
      },
      exclude = {
        filetypes = { 'help', 'dashboard', 'NvimTree' },
      },
    }

    local hooks = require 'ibl.hooks'

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
