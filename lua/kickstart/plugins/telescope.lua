return {
  'nvim-telescope/telescope.nvim',

  event = 'VimEnter',
  branch = '0.1.x',

  dependencies = {
    'nvim-lua/plenary.nvim',

    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    { 'nvim-telescope/telescope-ui-select.nvim' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    { 'nvim-telescope/telescope-file-browser.nvim' },

    { 'nvim-telescope/telescope-media-files.nvim' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-M-j>'] = function(prompt_bufnr)
              require('telescope.actions').preview_scrolling_down(prompt_bufnr)
            end,
            ['<C-M-k>'] = function(prompt_bufnr)
              require('telescope.actions').preview_scrolling_up(prompt_bufnr)
            end,
          },
          n = {
            ['<C-j>'] = function(prompt_bufnr)
              require('telescope.actions').preview_scrolling_down(prompt_bufnr)
            end,
            ['<C-k>'] = function(prompt_bufnr)
              require('telescope.actions').preview_scrolling_up(prompt_bufnr)
            end,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        file_browser = {
          theme = 'dropdown',
          hijack_netrw = true,
        },
        media_files = {
          filetypes = { 'png', 'jpg', 'mp4', 'webm', 'pdf' },
          find_cmd = 'rg',
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'media_files')

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.keymap.set('n', '<leader>ggc', builtin.git_commits, { desc = '[G]it [C]ommits' })
    vim.keymap.set('n', '<leader>ggb', builtin.git_branches, { desc = '[G]it [B]ranches' })
    vim.keymap.set('n', '<leader>ggs', builtin.git_status, { desc = '[G]it [S]tatus' })

    vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { desc = '[F]ile [B]rowser' })
    vim.keymap.set('n', '<leader>sm', ':Telescope media_files<CR>', { desc = '[S]earch [M]edia Files' })

    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = '[L]SP [S]ymbols' })
    vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = '[L]SP [W]orkspace Symbols' })

    local function visual_selection()
      vim.cmd 'noau normal! "vy"'
      return vim.fn.getreg 'v'
    end

    local last_search_string = nil
    local last_global_search_string = nil

    local function vscode_search()
      local search_string = vim.fn.mode() == 'v' and visual_selection() or last_search_string

      builtin.current_buffer_fuzzy_find {
        default_text = search_string,
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'bottom',
          preview_width = 0.5,
          width = 0.9,
          height = 0.8,
        },
        winblend = 10,
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local input = require('telescope.actions.state').get_current_line()

            last_search_string = input
            vim.fn.setreg('/', input)
            require('telescope.actions').select_default(prompt_bufnr)
          end)
          return true
        end,
      }
    end

    local function vscode_global_search()
      local search_string = vim.fn.mode() == 'v' and visual_selection() or last_global_search_string

      builtin.live_grep {
        default_text = search_string,
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'bottom',
          preview_width = 0.5,
          width = 0.9,
          height = 0.8,
        },
        winblend = 10,
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local input = require('telescope.actions.state').get_current_line()

            last_global_search_string = input
            require('telescope.actions').select_default(prompt_bufnr)
          end)
          return true
        end,
      }
    end

    vim.keymap.set({ 'n', 'v' }, '<D-f>', vscode_search, { desc = 'VS Code search (current buffer)' })
    vim.keymap.set({ 'n', 'v' }, '<D-S-f>', vscode_global_search, { desc = 'VS Code global search (project)' })
  end,
}
