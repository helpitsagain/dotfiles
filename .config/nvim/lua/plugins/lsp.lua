return {
  -- MASON
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'stylua',
        'lua-language-server',
        'luacheck',
        'shellcheck',
        'shfmt',
        'css-lsp',
        'html-lsp',
        'typescript-language-server',
        'eslint-lsp',
        'rust-analyzer',
        'json-lsp',
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

      tsserver = {
        root_dir = function(fname)
          return require('lspconfig/util').root_pattern('tsconfig.json')(fname)
            or require('lspconfig/util').root_pattern('jsconfig.json')(fname)
            or require('lspconfig/util').root_pattern('.git')(fname)
            or require('lspconfig/util').root_pattern('.svn')(fname)
            or require('lspconfig/util').root_pattern('.hg')(fname)
        end,
        single_file_support = true,
        settings = {
          documentFormatting = false,
          typescript = {
            format = 'prettier',
            formatOptions = {
              tabWidth = 2,
              singleQuote = true,
              trailingComma = 'all',
              bracketSpacing = true,
              semi = false,
              useTabs = false,
            },
            inlay_hints = {
              chainingHints = true,
              parameterHints = true,
            },
          },
        },
      },

      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
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
    },
  },
}
