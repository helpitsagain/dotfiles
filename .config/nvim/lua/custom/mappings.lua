---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },

    ["<leader>ol"] = { "<cmd> :Lazy<CR>", "open Lazy"},
    ["<leader>om"] = { "<cmd> :Mason<CR>", "open Mason"},

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
