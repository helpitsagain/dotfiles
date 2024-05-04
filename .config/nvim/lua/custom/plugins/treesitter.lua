return {
  {
    'nvim-treesitter/nvim-treesitter',
    ensure_installed = {
      'vim',
      'lua',
      'html',
      'css',
      'javascript',
      'typescript',
      'tsx',
      'c',
      'markdown',
      'markdown_inline',
      'c_sharp',
    },
    indent = {
      enable = true,
      -- disable = {
      --   "python"
      -- },
    },
  },
}
