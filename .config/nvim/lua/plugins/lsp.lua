local lspconfig = require('lspconfig')
local util = lspconfig.util

return {
  -- MASON
  --
  {
    'mason-org/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'stylua',
        'lua-language-server',
        'luacheck',
        'shellcheck',
        'shfmt',
        'css-lsp',
        'html-lsp',
        'eslint-lsp',
        'rust-analyzer',
        'json-lsp',
        'csharp-language-server',
        'omnisharp',
        'pyright',
        'black',
      })
    end,
  },

  -- LSPCONFIG
  {
    'neovim/nvim-lspconfig',
    opts = {
      event = 'BufReadPre',
      inlay_hints = {
        show_parameter_hints = true,
        prefix = '🔍 ',
        highlight = 'Comment',
      },
    },
    servers = {

      lua_ls = {
        single_file_support = true,

        settings = {

          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              workspaceWord = true,
              callSnippet = 'Both',
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = 'Disable',
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
            doc = {
              privateName = { '^_' },
            },
            diagnostics = {
              disable = { 'unused-local', 'undefined-global', 'incomplete-signature-doc' },
              globals = { 'vim' },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = 'space',
                indent_size = 2,
                continuation_indent_size = 2,
              },
            },
          },
        },
      },

      cssls = {},

      html = {},

      jsonls = {},

      rust_analyzer = {
        settings = {
          ['rust_analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },

      csharp_ls = {},

      pyright = {},
    },
  },

  -- NONE-LS
  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.black,
      })
    end,
  },
}
