-- Copilot.

return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   opts = {
  --     panel = {
  --       enabled = true,
  --       auto_refresh = false,
  --       keymap = {
  --         jump_prev = '[[',
  --         jump_next = ']]',
  --         accept = '<CR>',
  --         refresh = 'gr',
  --       },
  --       layout = {
  --         position = 'bottom', -- | top | left | right
  --         ratio = 0.4,
  --       },
  --     },
  --     suggestion = {
  --       enalbed = true,
  --       auto_trigger = false,
  --       -- Use alt to interact with Copilot.
  --       keymap = {
  --         -- Disable the built-in mapping, we'll configure it in nvim-cmp.
  --         accept = false,
  --         accept_word = '<M-w>',
  --         accept_line = '<M-l>',
  --         next = '<M-]>',
  --         prev = '<M-[>',
  --         dismiss = '/',
  --       },
  --     },
  --     filetypes = {
  --       markdown = true,
  --       typescript = true,
  --       typescriptreact = true,
  --       javascript = true,
  --       javascriptreact = true,
  --       css = true,
  --       scss = true,
  --       html = true,
  --       gitcommit = true,
  --     },
  --     copilot_node_command = 'node',
  --   },
  --   config = function(_, opts)
  --     local cmp = require('cmp')
  --     local copilot = require('copilot.suggestion')
  --     local luasnip = require('luasnip')
  --
  --     require('copilot').setup(opts)
  --
  --     local function set_trigger(trigger)
  --       vim.b.copilot_suggestion_auto_trigger = trigger
  --       vim.b.copilot_suggestion_hidden = not trigger
  --     end
  --
  --     -- Hide suggestions when the completion menu is open.
  --     cmp.event:on('menu_opened', function()
  --       if copilot.is_visible() then
  --         copilot.dismiss()
  --       end
  --       set_trigger(false)
  --     end)
  --
  --     -- Disable suggestions when inside a snippet.
  --     cmp.event:on('menu_closed', function()
  --       set_trigger(not luasnip.expand_or_locally_jumpable())
  --     end)
  --     vim.api.nvim_create_autocmd('User', {
  --       pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
  --       callback = function()
  --         set_trigger(not luasnip.expand_or_locally_jumpable())
  --       end,
  --     })
  --   end,
  -- },
}
