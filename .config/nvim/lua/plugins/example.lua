---@diagnostic disable: undefined-doc-name
-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { 'ellisonleao/gruvbox.nvim' },

  -- Configure LazyVim to load gruvbox
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'gruvbox',
    },
  },

  -- change trouble config
  {
    'folke/trouble.nvim',
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { 'folke/trouble.nvim', enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'emoji' })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local cmp = require('cmp')

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    'neovim/nvim-lspconfig',
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = 'lazyvim.plugins.extras.lang.typescript' },

  -- add more treesitter parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'bash',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'vim',
        'yaml',
        'rust',
        'csharp',
      },
      indent = { enabled = true },
      highlight = { enabled = true },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        'tsx',
        'typescript',
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, '😄')
    end,
  },

  -- or you can return new options to override all the defaults
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = 'lazyvim.plugins.extras.ui.mini-starter' },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = 'lazyvim.plugins.extras.lang.json' },

  -- add any tools you want to have installed below
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'flake8',
      },
    },
  },

  -- -- Use <tab> for completion and snippets (supertab)
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-emoji',
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  --     end
  --
  --     local cmp = require('cmp')
  --
  --     opts.mapping = vim.tbl_extend('force', opts.mapping, {
  --       ['<Tab>'] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --         elseif vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { 'i', 's' }),
  --       ['<S-Tab>'] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif vim.snippet.active({ direction = -1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(-1)
  --           end)
  --         else
  --           fallback()
  --         end
  --       end, { 'i', 's' }),
  --     })
  --   end,
  -- },
}
