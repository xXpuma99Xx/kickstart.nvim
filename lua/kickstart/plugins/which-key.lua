return {
  'folke/which-key.nvim',

  event = 'VimEnter',
  opts = {
    delay = 0,

    icons = {
      mappings = vim.g.have_nerd_font,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '↑',
          Down = '↓',
          Left = '←',
          Right = '→',
          C = '⌃',
          M = '⌥',
          D = '⌘',
          S = '⇧',
          CR = '↵',
          Esc = '⎋',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '↵',
          BS = '⌫',
          Space = '␣',
          Tab = '⇥',
          F1 = 'F1',
          F2 = 'F2',
          F3 = 'F3',
          F4 = 'F4',
          F5 = 'F5',
          F6 = 'F6',
          F7 = 'F7',
          F8 = 'F8',
          F9 = 'F9',
          F10 = 'F10',
          F11 = 'F11',
          F12 = 'F12',
        },
      },
    },

    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' }, desc = 'Code actions' },
      { '<leader>d', group = '[D]ocument', desc = 'Document actions' },
      { '<leader>r', group = '[R]ename', desc = 'Rename symbol' },
      { '<leader>s', group = '[S]earch', desc = 'Search actions' },
      { '<leader>w', group = '[W]orkspace', desc = 'Workspace actions' },
      { '<leader>t', group = '[T]oggle', desc = 'Toggle options' },
      { '<leader>g', group = 'Git [H]unk', mode = { 'n', 'v' }, desc = 'Git hunk actions' },
    },

    win = {
      border = 'rounded',
    },
  },
}
