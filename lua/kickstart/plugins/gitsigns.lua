return {
  'lewis6991/gitsigns.nvim',

  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },

    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      map('v', '<leader>gs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [s]tage hunk' })
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })

      map('v', '<leader>gr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [r]eset hunk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })

      map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
      map('n', '<leader>gU', function()
        local file_path = vim.fn.expand '%:p'

        if file_path == '' then
          vim.notify('No file is open', vim.log.levels.WARN)
          return
        end

        local cmd = string.format('git reset -- %s', vim.fn.shellescape(file_path))

        vim.fn.system(cmd)
        vim.notify('Unstaged entire buffer: ' .. file_path, vim.log.levels.INFO)
        require('gitsigns').refresh()
      end, { desc = 'git [u]nstage buffer' })

      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
      map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
      map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = 'git [D]iff against last commit' })

      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      map('n', '<leader>tl', gitsigns.toggle_linehl, { desc = '[T]oggle git show [l]ine highlight' })
    end,
  },
}
