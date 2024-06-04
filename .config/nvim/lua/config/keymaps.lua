-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", ";", ":")

map("i", "jk", "<esc>", { desc = "Esc" })

map({ "n", "i", "v" }, "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

-- TODO: set keymaps for neotree
