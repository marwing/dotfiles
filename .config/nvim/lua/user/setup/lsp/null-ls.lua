local null_ls = require('null-ls')
null_ls.setup {
  on_attach = require('user.setup.lsp.overrides').on_attach,
  sources = {
    -- common
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.gitrebase,

    -- C++
    null_ls.builtins.diagnostics.cppcheck,

    -- shell
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.zsh,

    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.selene.with {
      cwd = function()
        -- falls back to cwd if return is nil
        return vim.fs.dirname(vim.fs.find('selene.toml', { upward = true, path = vim.api.nvim_buf_get_name(0) })[1])
      end,
    },
  },
}
