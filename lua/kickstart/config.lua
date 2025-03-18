vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true

local function toggle_relative_number()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
    print 'Números absolutos activados'
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
    print 'Números relativos activados'
  end
end

vim.keymap.set('n', '<leader>tn', toggle_relative_number, { desc = 'Toggle relative number', noremap = true, silent = true })

vim.opt.mouse = 'a'
vim.opt.mousemoveevent = true

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
  if vim.bo.modifiable then
    vim.cmd 'w'
    print '💾 Archivo guardado!'
  else
    print '❌ No se puede guardar este archivo!'
  end
end, { desc = 'Guardar archivo', noremap = true, silent = true })

local function save_file()
  if vim.bo.modifiable then
    vim.cmd 'w'
    print '💾 Archivo guardado!'
  else
    print '❌ No se puede guardar este archivo!'
  end
end

vim.keymap.set({ 'n', 'i' }, '<C-s>', save_file, { desc = 'File saved', noremap = true, silent = true })

vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Close', noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-z>', 'u', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-S-z>', '<C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-z>', '<C-o><C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-z>', '<C-r>', { noremap = true, silent = true })

local function extend_linewise_visual_selection()
  if vim.fn.mode() == 'V' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('j', true, true, true), 'x', false)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('V', true, true, true), 'n', false)
  end
end

vim.keymap.set('n', '<leader><C-l>', extend_linewise_visual_selection, { noremap = true, silent = true })
vim.keymap.set('v', '<C-l>', extend_linewise_visual_selection, { noremap = true, silent = true })

vim.opt.commentstring = '// %s'

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move current line down' })
vim.keymap.set('n', '<A-k>', ':m .-3<CR>==', { noremap = true, silent = true, desc = 'Move current line up' })

vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true, desc = 'Move current line up (insert mode)' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true, desc = 'Move current line down (insert mode)' })

vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected block up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected block down' })
