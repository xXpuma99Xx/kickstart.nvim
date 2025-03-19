return {
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_enable_italic = true
    vim.g.everforest_background = 'hard'
    vim.g.everforest_sign_column_background = 'grey'
    vim.cmd.colorscheme 'everforest'
  end,
}
