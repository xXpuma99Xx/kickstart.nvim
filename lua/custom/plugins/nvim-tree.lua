return {
  'nvim-tree/nvim-tree.lua',

  version = '*',
  lazy = false,

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local api = require 'nvim-tree.api'

    local function my_on_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', 'g?', api.tree.toggle_help, opts 'Help')
      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts 'CD')
      vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Up')
      vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts 'Toggle Filter: No Buffer')
      vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts 'Toggle Filter: Git Clean')
      vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts 'Toggle Filter: Dotfiles')
      vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts 'Toggle Filter: Git Ignore')
      vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts 'Toggle Filter: No Bookmark')
      vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts 'Toggle Filter: Hidden')
      vim.keymap.set('n', 'E', api.tree.expand_all, opts 'Expand All')
      vim.keymap.set('n', 'W', api.tree.collapse_all, opts 'Collapse')
      vim.keymap.set('n', '<C-f>', api.tree.search_node, opts 'Search')
      vim.keymap.set('n', 'R', api.tree.reload, opts 'Refresh')
      vim.keymap.set('n', 'q', api.tree.close, opts 'Close')
      vim.keymap.set('n', '<C-|>', api.node.open.vertical, opts 'Open: Vertical Split')
      vim.keymap.set('n', '<C-->', api.node.open.horizontal, opts 'Open: Horizontal Split')
      vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts 'Open: In Place')
      vim.keymap.set('n', '<C-t>', api.node.open.tab, opts 'Open: New Tab')
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts 'Open Preview')
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', 'o', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts 'Open: No Window Picker')
      vim.keymap.set('n', 'L', api.node.open.toggle_group_empty, opts 'Toggle Group Empty')
      vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts 'Close Directory')
      vim.keymap.set('n', 'P', api.node.navigate.parent, opts 'Parent Directory')
      vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts 'Next Sibling')
      vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts 'Previous Sibling')
      vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts 'Last Sibling')
      vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts 'First Sibling')
      vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'Prev Git')
      vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'Next Git')
      vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts 'Next Diagnostic')
      vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts 'Prev Diagnostic')
      vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts 'Info')
      vim.keymap.set('n', '.', api.node.run.cmd, opts 'Run Command')
      vim.keymap.set('n', 's', api.node.run.system, opts 'Run System')
      vim.keymap.set('n', 'a', api.fs.create, opts 'Create File Or Directory')
      vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
      vim.keymap.set('n', 'u', api.fs.rename_full, opts 'Rename: Full Path')
      vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts 'Rename: Omit Filename')
      vim.keymap.set('n', 'e', api.fs.rename_basename, opts 'Rename: Basename')
      vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
      vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts 'Copy Relative Path')
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
      vim.keymap.set('n', 'ge', api.fs.copy.basename, opts 'Copy Basename')
      vim.keymap.set('n', 'd', api.fs.remove, opts 'Delete')
      vim.keymap.set('n', 'D', api.fs.trash, opts 'Trash')
      vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
      vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
      vim.keymap.set('n', 'm', api.marks.toggle, opts 'Toggle Bookmark')
      vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts 'Move Bookmarked')
      vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts 'Delete Bookmarked')
      vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts 'Trash Bookmarked')
      vim.keymap.set('n', 'F', api.live_filter.clear, opts 'Live Filter: Clear')
      vim.keymap.set('n', 'f', api.live_filter.start, opts 'Live Filter: Start')
      vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts 'Open')
      vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts 'CD')
    end

    require('nvim-tree').setup {
      on_attach = my_on_attach,
      hijack_cursor = false,
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      select_prompts = false,

      sort = {
        sorter = 'name',
        folders_first = true,
        files_first = false,
      },

      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        side = 'left',
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
        width = 35,
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = 'editor',
            border = 'rounded',
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },

      renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ':~:s?$?/..?',
        indent_width = 2,
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        hidden_display = 'none',
        symlink_destination = true,
        decorators = { 'Git', 'Open', 'Hidden', 'Modified', 'Bookmark', 'Diagnostics', 'Copied', 'Cut' },
        highlight_git = 'icon',
        highlight_diagnostics = 'all',
        highlight_opened_files = 'none',
        highlight_modified = 'name',
        highlight_hidden = 'none',
        highlight_bookmarks = 'none',
        highlight_clipboard = 'name',
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            bottom = '─',
            none = ' ',
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = 'before',
          modified_placement = 'after',
          hidden_placement = 'after',
          diagnostics_placement = 'signcolumn',
          bookmarks_placement = 'signcolumn',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = '',
            symlink = '',
            bookmark = '󰆤',
            modified = '●',
            hidden = '󰜌',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },

      hijack_directories = {
        enable = true,
        auto_open = true,
      },

      update_focused_file = {
        enable = true,
        update_root = true, -- { enable = false, ignore_list = {} }
        -- exclude = false,
      },

      system_open = {
        cmd = '',
        args = {},
      },

      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
      },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        debounce_delay = 500,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        },
      },

      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },

      filters = {
        enable = true,
        git_ignored = true,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        no_bookmark = false,
        custom = {},
        exclude = {},
      },

      live_filter = {
        prefix = '[FILTER]: ',
        always_show_folders = true,
      },

      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
          '/.ccls-cache',
          '/build',
          '/node_modules',
          '/target',
        },
      },

      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = 'cursor',
            border = 'shadow',
            style = 'minimal',
          },
        },
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          relative_path = true,
          window_picker = {
            enable = true,
            picker = 'default',
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },

      trash = {
        cmd = 'gio trash',
      },

      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },

      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
      },

      help = {
        sort_by = 'key',
      },

      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = false,
        },
      },

      experimental = {},

      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    }

    vim.keymap.set('n', '<C-b>', api.tree.toggle, { noremap = true, silent = true, nowait = true })
    vim.keymap.set('n', '<C-M-b>', '<cmd> NvimTreeFocus <CR>', { desc = 'nvim-tree: Focus', noremap = true, silent = true })

    local close = function()
      if api.tree.is_visible() then
        api.tree.toggle()
      end
      vim.cmd 'wall'
      vim.cmd '%bdelete'
      vim.cmd 'qall'
    end

    vim.keymap.set('n', '<leader><C-q>', close, { desc = 'Quit Nvim', noremap = true, silent = true })
  end,
}
