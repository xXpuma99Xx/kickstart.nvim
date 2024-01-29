return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
        },
      },
      filters = {
        dotfiles = false,
        custom = { '^\\.git', '^node_modules$' },
      },
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local function edit_or_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file
            api.node.open.edit()
          end
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<leader>|', api.node.open.vertical, opts 'Vsplit Preview')
        vim.keymap.set('n', '<leader>-', api.node.open.horizontal, opts 'Hsplit Preview')

        vim.keymap.set('n', 'l', edit_or_open, opts 'Expand folder/Open file')
        vim.keymap.set('n', 'h', api.node.open.edit, opts 'Close folder')
        vim.keymap.set('n', 'H', api.tree.collapse_all, opts 'Collapse All')

        vim.keymap.set('n', '<C-i>', api.node.show_info_popup, opts 'Info')
      end,
    }
    vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<cr>',
      { silent = true, noremap = true, desc = 'nvim-tree: open/close' })
    vim.api.nvim_set_keymap('n', '<leader>b', ':NvimTreeFocus<cr>',
      { silent = true, noremap = true, desc = 'nvim-tree: Focus' })
    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      callback = function()
        -- open the tree, find the file but don't focus it
        require('nvim-tree.api').tree.toggle { focus = true, find_file = true }
      end,
    })
  end,
}
