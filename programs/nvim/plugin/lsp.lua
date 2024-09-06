local on_attach = function(_, bufnr)
  -- Your existing on_attach function...
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()

local lspconfig = require('lspconfig')

-- Lua LSP
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    }
}

-- Nix LSP
lspconfig.nixd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- You can add more LSP configurations here

