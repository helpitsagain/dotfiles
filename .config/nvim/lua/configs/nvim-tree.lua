local options = {
  view = {
    cursorline = false,
    relativenumber = true,
    centralize_selection = true,
    width = {
      min = 20,
      max = 40,
      padding = 1,
    },
  },

  git = {
    enable = true,
  },

  renderer = {
    full_name = true,
    root_folder_label = false,
    highlight_git = 'all',
    highlight_diagnostics = 'name',
    indent_markers = {
      enable = true,
      inline_arrows = false,
    },
    icons = {
      show = {
        git = true,
      },
      git_placement = 'after',
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '󰆤',
        modified = '●',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },

  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },

  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    -- load default keybindings
    api.config.mappings.default_on_attach(bufnr)

    -- set custom keybindings
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  end,
}

require('nvim-tree').setup(options)
