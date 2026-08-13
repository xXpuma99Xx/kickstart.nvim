return {
  'epwalsh/obsidian.nvim',

  version = '*',

  lazy = true,
  ft = 'markdown',

  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },

  opts = {
    workspaces = {
      {
        name = 'AWS',
        path = '~/Documents/obsidian/cursos/aws',
      },
      {
        name = 'Docker',
        path = '~/Documents/obsidian/cursos/docker',
      },
      {
        name = 'Go',
        path = '~/Documents/obsidian/cursos/go',
      },
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    picker = {
      name = 'telescope.nvim',
    },

    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    preferred_link_style = 'wiki',

    sort_by = 'modified',
    sort_reversed = true,

    ui = {
      enable = false,
    },
  },
}
