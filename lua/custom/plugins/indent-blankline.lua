return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  dependencies = {
    'TheGLander/indent-rainbowline.nvim',
  },
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  opts = function(_, opts)
    -- Other blankline configuration here
    return require('indent-rainbowline').make_opts(opts)
  end,
}
