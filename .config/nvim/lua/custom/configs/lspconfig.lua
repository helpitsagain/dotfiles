-- -- something was breaking in the lspconfig so I'm commenting it all out until I have the time to figure it out
--
-- local lspconfig = require("plugins.configs.lspconfig")
--
-- local on_attach = lspconfig.on_attach
-- local capabilities = lspconfig.capabilities
--
-- -- if you just want default config for the servers then put them in a table
-- local servers = {
--   "lua-language-server",
--   "stylua",
--   "lua_ls",
--   "css-lsp",
--   "html-lsp",
--   "typescript-language-server",
--   "tsserver",
--   "deno",
--   "prettier",
--   "clangd",
--   "clang-format",
-- }
--
-- for _, lsp in ipairs(servers) do
--   if lspconfig[lsp] then
--     lspconfig[lsp].setup {
--       on_attach = on_attach,
--       capabilities = capabilities,
--     }
--   else
--     print('Warrning: Configuration for ' .. lsp .. ' not found.')
--   end
-- end

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})
