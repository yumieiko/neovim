local cmp = require'cmp'
local cmp_nvim_lsp = require'cmp_nvim_lsp'
local lspconfig_util = require('lspconfig.util')

function deepest_root_pattern(patterns1, patterns2)
  -- Create two root_pattern functions
  local find_root1 = lspconfig_util.root_pattern(unpack(patterns1))
  local find_root2 = lspconfig_util.root_pattern(unpack(patterns2))

  return function(startpath)
    local path1 = find_root1(startpath)
    local path2 = find_root2(startpath)

    if path1 and path2 then
      -- Count the number of slashes to determine the path length
      local path1_length = select(2, path1:gsub("/", ""))
      local path2_length = select(2, path2:gsub("/", ""))

      if path1_length > path2_length then
        return path1
      end

    elseif path1 then
      return path1
    end

    return nil
  end
end

vim.diagnostic.config({
    virtual_text = true, -- Show warnings/errors inline with the code
    signs = true,        -- Show signs in the gutter (left-hand side)
    underline = true,    -- Underline warnings/errors
    update_in_insert = false, -- Do not update diagnostics while typing
})

-- Define custom diagnostic signs (optional)
cmp.setup({
	snippet = {
        expand = function(args)
            -- Use a snippet engine like "luasnip" here
        end,
    },
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
  capabilities = capabilities,
  on_attach = function(client, bufnr)
        -- Enable diagnostics
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        })
    end,
}
require('lspconfig')['denols'].setup{
	capabilities = capabilities,
	root_dir = deepest_root_pattern({"deno.json", "deno.jsonc", "import_map.json"}, {"package.json", "tsconfig.json"})

}
