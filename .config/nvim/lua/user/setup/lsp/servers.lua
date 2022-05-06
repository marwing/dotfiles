local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local on_attach = require('user.setup.lsp.mappings')
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local servers = { "cmake", "pylsp", "pyright", "texlab", "tsserver" }
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- clangd_extensions
local has_clangd_extensions, clangd_extensions = pcall(require, "clangd_extensions")
if has_clangd_extensions then
  clangd_extensions.setup {
    server = {
      cmd = { "clangd", "-query-driver=/usr/**/arm-none-eabi*", "--completion-style=detailed", "--malloc-trim", "--enable-config", "--use-dirty-headers" },
      on_attach = on_attach,
      capabilities = capabilities,
    },
    extensions = {
      autoSetHints = false,
    }
  }
end

-- rust-tools
local has_rust_tools, rust_tools = pcall(require, "rust-tools")
if has_rust_tools then
  rust_tools.setup {
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
    tools = {
      hover_with_actions = false,
    },
  }
end

-- sumneko_lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
