local lspconfig = require('lspconfig')
local util = lspconfig.util

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
        'eslint-lsp',
        'rust-analyzer',
        'json-lsp',
        'pyright',
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

      pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_dir = function(fname)
          local root_files = {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json',
            '.git',
          }
          return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
        commands = {
          PyrightOrganizeImports = {
            function()
              local params = {
                command = 'pyright.organizeimports',
                arguments = { vim.uri_from_bufnr(0) },
              }

              local clients = util.get_lsp_clients({
                bufnr = vim.api.nvim_get_current_buf(),
                name = 'pyright',
              })
              for _, client in ipairs(clients) do
                client.request('workspace/executeCommand', params, nil, 0)
              end
            end,
            description = 'Organize Imports',
          },
          PyrightSetPythonPath = {
            function(path)
              local clients = util.get_lsp_clients({
                bufnr = vim.api.nvim_get_current_buf(),
                name = 'pyright',
              })
              for _, client in ipairs(clients) do
                if client.settings then
                  client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
                else
                  client.config.settings =
                    vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
                end
                client.notify('workspace/didChangeConfiguration', { settings = nil })
              end
            end,
            description = 'Reconfigure pyright with the provided python path',
            nargs = 1,
            complete = 'file',
          },
        },
      },
    },
  },
}
