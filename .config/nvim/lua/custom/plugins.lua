local overrides = require('custom.configs.overrides')

--@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   lazy = false,
  -- },

  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("plugins.configs.lspconfig")
  --     require("custom.configs.lspconfig")
  --   end, -- Override to setup mason-lspconfig
  -- },
  --
  -- -- override plugin configs
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require("mason").setup()
  --   end
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   -- opts = overrides.mason,
  --   config = function()
  --     require("mason-lspconfig").setup({
  --       ensure_installed = {
  --         "lua_ls",
  --         "tsserver",
  --       }
  --     })
  --   end
  -- },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  -- {
  --   "stevearc/conform.nvim",
  --   --  for users those who want auto-save conform + lazyloading!
  --   -- event = "BufWritePre"
  --   config = function()
  --     ---@diagnostic disable-next-line: different-requires
  --     require("custom.configs.conform")
  --   end,
  -- },

  -- {
  --   "nvim-telescope/telescope-ui-select.nvim",
  --   opts = overrides.telescope_ui_select,
  -- }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
