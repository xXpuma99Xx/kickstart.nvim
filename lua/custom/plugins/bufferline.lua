return {
  'akinsho/bufferline.nvim',

  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',

  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        mode = 'buffers',
        style_preset = bufferline.style_preset.default,
        themable = true,
        numbers = 'ordinal',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,

        indicator = {
          icon = '▎',
          style = 'icon',
        },

        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        diagnostics_update_on_event = true,

        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },

        color_icons = true,

        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        duplicates_across_groups = true,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        separator_style = 'thick',
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        auto_toggle_bufferline = true,

        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },

        pick = {
          alphabet = 'abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890',
        },
      },
    }

    local function map_bufferline_keys()
      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, function()
          bufferline.go_to(i, true)
        end, { desc = 'Go to buffer ' .. i, noremap = true, silent = true })
      end
    end

    map_bufferline_keys()

    local function close_buffer()
      local bufnum = vim.api.nvim_get_current_buf()
      bufferline.cycle(-1)
      vim.api.nvim_buf_delete(bufnum, { force = true })
    end

    vim.keymap.set('n', '<leader><C-w>', close_buffer, { desc = 'Close current buffer', noremap = true, silent = true })

    vim.keymap.set('n', '<leader>bl', ':BufferLineCycleNext<CR>', { desc = 'Next buffer', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>bh', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })

    vim.keymap.set('n', '<leader>bml', ':BufferLineMoveNext<CR>', { desc = 'Move buffer next', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>bmh', ':BufferLineMovePrev<CR>', { desc = 'Move buffer previous', noremap = true, silent = true })

    vim.keymap.set('n', '<leader>ba', ':BufferLineCloseOthers<CR>', { desc = 'Close other buffers', noremap = true, silent = true })

    vim.keymap.set('n', '<leader>bs', bufferline.pick, { noremap = true, silent = true, desc = 'Pick buffer' })

    local function smart_split(split_cmd)
      return function()
        local buffers = vim.fn.getbufinfo { buflisted = 1 }
        local current_buf = vim.api.nvim_get_current_buf()

        if #buffers >= 2 then
          vim.cmd 'BufferLineCyclePrev'
        end
        vim.cmd(split_cmd)
        vim.api.nvim_set_current_buf(current_buf)
      end
    end

    vim.keymap.set('n', '<C-|>', smart_split 'vsplit', { noremap = true, silent = true, desc = 'Smart vertical split' })
    vim.keymap.set('n', '<C-->', smart_split 'split', { noremap = true, silent = true, desc = 'Smart horizontal split' })
  end,
}
