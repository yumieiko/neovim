local cmp = require'cmp'
local cmp_nvim_lsp = require'cmp_nvim_lsp'
cmp.setup({
	window = {
      completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
	mapping = cmp.mapping.preset.insert({
      		['<C-b>'] = cmp.mapping.scroll_docs(-4),
      		['<C-f>'] = cmp.mapping.scroll_docs(4),
      		['<C-Space>'] = cmp.mapping.complete(),
      		['<C-e>'] = cmp.mapping.abort(),
      		['<CR>'] = cmp.mapping.confirm({ select = true }),
   	}),
	sources = cmp.config.sources({
      		{ name = 'nvim_lsp' },
	}, {
      { name = 'buffer' },
    })
})

local capabilities = cmp_nvim_lsp.default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
