return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvimtools/none-ls-extras.nvim' },
    lazy = false,
    requires = { 'nvim-lua/plenary.nvim' },

    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          require('none-ls.diagnostics.eslint_d')
        },
      })

      vim.keymap.set('n', '<leader>fp', vim.lsp.buf.format, {})
    end,
  },
}
