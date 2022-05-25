local null_ls = require('null-ls')
null_ls.setup {
  on_attach = require('user.setup.lsp.overrides').on_attach,
  sources = {
    -- common
    null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.completion.spell, -- speed?

    -- C++
    -- null_ls.builtins.diagnostics.cppcheck, -- benefit on top of clangd?

    -- shell
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.zsh,

    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.selene,
  },
}
