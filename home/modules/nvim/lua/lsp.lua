local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
lspconfig.lua_ls.setup({
	capabilities = capabilities,
})
lspconfig.nixd.setup({
	capabilities = capabilities,
})
lspconfig.clangd.setup({
	capabilities = capabilities,
})
