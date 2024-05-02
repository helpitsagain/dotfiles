----@type MappingsTable
local mappings = {}

mappings.general = {
  n = {
    [';'] = { ':', 'enter command mode', opts = { nowait = true } },

    -- Navigate seamlessly between neovim and tmux
    ['<C-h>'] = { '<cmd> TmuxNavigateLeft<CR>', 'window left' },
    ['<C-j>'] = { '<cmd> TmuxNavigateDown<CR>', 'window down' },
    ['<C-k>'] = { '<cmd> TmuxNavigateUp<CR>', 'window up' },
    ['<C-l>'] = { '<cmd> TmuxNavigateRight<CR>', 'window right' },

    ['<leader>ol'] = { '<cmd> :Lazy<CR>', 'open Lazy' },
    ['<leader>om'] = { '<cmd> :Mason<CR>', 'open Mason' },

    ['gD'] = {
      function()
        vim.lsp.buf.declaration()
      end,
      'LSP declaration',
    },

    ['gd'] = {
      function()
        vim.lsp.buf.definition()
      end,
      'LSP definition',
    },

    ['K'] = {
      function()
        vim.lsp.buf.hover()
      end,
      'LSP hover',
    },

    ['gi'] = {
      function()
        vim.lsp.buf.implementation()
      end,
      'LSP implementation',
    },

    ['<leader>ls'] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      'LSP signature help',
    },

    ['<leader>D'] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      'LSP definition type',
    },

    ['<leader>ra'] = {
      function()
        require('nvchad.renamer').open()
      end,
      'LSP rename',
    },

    ['<leader>ca'] = {
      function()
        vim.lsp.buf.code_action()
      end,
      'LSP code action',
    },

    ['gr'] = {
      function()
        vim.lsp.buf.references()
      end,
      'LSP references',
    },

    ['<leader>lf'] = {
      function()
        vim.diagnostic.open_float({ border = 'rounded' })
      end,
      'Floating diagnostic',
    },

    ['[d'] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = 'rounded' } })
      end,
      'Goto prev',
    },

    [']d'] = {
      function()
        vim.diagnostic.goto_next({ float = { border = 'rounded' } })
      end,
      'Goto next',
    },

    ['<leader>q'] = {
      function()
        vim.diagnostic.setloclist()
      end,
      'Diagnostic setloclist',
    },

    ['<leader>wa'] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      'Add workspace folder',
    },

    ['<leader>wr'] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      'Remove workspace folder',
    },

    ['<leader>wl'] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      'List workspace folders',
    },

    -- ["<leader>fm"] = {
    --   function()
    --     vim.lsp.buf.format()
    --   end,
    --   "Format file using none-ls",
    -- },
  },

  v = {
    ['>'] = { '>gv', 'indent' },
  },
}

-- more keybinds!

return mappings
