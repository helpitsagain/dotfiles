local overrides = {}

overrides.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

overrides.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "lua_ls",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "tsserver",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
overrides.nvimtree = {
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  view = {
    relativenumber = true
  },

}

return overrides
