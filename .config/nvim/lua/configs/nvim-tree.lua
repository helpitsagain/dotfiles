local options = {
  view = {
    cursorline = true,
    relativenumber = true,
    width = {
      min = 0,
      max = 50,
      padding = 2,
    },
  },

  hijack_cursor = true,

  update_focused_file = {
    enable = true,
    update_root = false,
  },

  filters = {
    enable = true,
    git_ignored = false,
    git_clean = false,
    dotfiles = false,
    no_buffer = false,
    no_bookmark = false,
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

-- highlights
vim.cmd([[
  :hi NvimTreeCursorLine guibg=#252434 gui=bold
]])