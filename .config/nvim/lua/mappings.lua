require('nvchad.mappings')

-- add yours here

local map = vim.keymap.set

-- Navigate seamlessly between neovim and tmux
map('n', '<C-h>', '<CMD> TmuxNavigateLeft<CR>', { desc = 'Navigate Left' })
map('n', '<C-j>', '<CMD> TmuxNavigateDown<CR>', { desc = 'Navigate Down' })
map('n', '<C-k>', '<CMD> TmuxNavigateUp<CR>', { desc = 'Navigate Up' })
map('n', '<C-l>', '<CMD> TmuxNavigateRight<CR>', { desc = 'Navigate Right' })

map('n', ';', ':', { desc = 'CMD enter command mode' })
map('i', 'jk', '<ESC>')

map('n', '<leader>ol', '<CMD> :Lazy<CR>', { desc = 'Open Lazy' })
map('n', '<leader>om', '<CMD> :Mason<CR>', { desc = 'Open Mason' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
