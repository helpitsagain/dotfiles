-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set('n', ';', ':', { desc = 'Command', silent = true, noremap = true })

keymap.set('i', 'jk', '<esc>', { desc = 'Esc', silent = true, noremap = true })

keymap.set(
  { 'n', 'i', 'v' },
  '<C-n>',
  '<cmd>Neotree toggle<cr>',
  { desc = 'Toggle Neotree', silent = true, noremap = true }
)

keymap.set({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete without yanking', silent = true, noremap = true })

keymap.set('n', '+', '<C-a>', { desc = 'Increment number', silent = true, noremap = true })
keymap.set('n', '-', '<C-x>', { desc = 'Decrement number', silent = true, noremap = true })

keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all', silent = true, noremap = true })

keymap.set('n', '<C-s>', '<cmd>update<cr>', { desc = 'Save', silent = true, noremap = true })
keymap.set('n', '<Leader>qw', '<cmd>wq<cr>', { desc = 'Save and Quit', silent = true, noremap = true })
keymap.set('n', '<Leader>Q', '<cmd>qa<cr>', { desc = 'Quit', silent = true, noremap = true })

keymap.set('n', '<tab>', '<cmd>tabnext<cr>', { desc = 'Next tab', silent = true, noremap = true })
keymap.set('n', '<S-tab>', '<cmd>tabprevious<cr>', { desc = 'Previous tab', silent = true, noremap = true })

keymap.del('n', 'H')
keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer', silent = true, noremap = true })
keymap.del('n', 'L')
keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer', silent = true, noremap = true })

keymap.set('n', 'n', 'nzzzv', { desc = 'Center next search result', silent = true, noremap = true })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Center prev search result', silent = true, noremap = true })

keymap.set(
  'n',
  '<Leader>gt',
  '<cmd>ToggleBlameLine<cr>',
  { desc = 'Toggle Git Blame Line', silent = true, noremap = true }
)
