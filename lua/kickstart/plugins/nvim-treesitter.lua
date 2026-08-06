return {
  'nvim-treesitter/nvim-treesitter',

  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    local treesitter = require 'nvim-treesitter'

    treesitter.setup {}

    treesitter.install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'java',
      'python',
      'javascript',
      'typescript',
      'json',
      'yaml',
      'css',
      'scss',
      'rust',
      'go',
      'php',
      'ruby',
      'sql',
      'dockerfile',
      'make',
      'cmake',
      'toml',
      'xml',
      'terraform',
      'vue',
      'svelte',
      'graphql',
    }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
