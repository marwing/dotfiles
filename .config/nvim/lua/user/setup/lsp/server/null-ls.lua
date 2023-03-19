return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup {
      on_attach = require('user.setup.lsp.utils.overrides').on_attach,
      sources = {
        -- git
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.gitrebase,

        -- C++
        null_ls.builtins.diagnostics.cppcheck,

        -- shell
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.formatting.shfmt.with {
          extra_args = function(params)
            local opts = params.options or {}

            return {
              '-i',
              opts.insertSpaces and opts.tabSize or 0,
              '-sr',
              '-ci',
            }
          end,
        },

        -- lua
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.selene.with {
          cwd = function()
            -- falls back to cwd if return is nil
            return vim.fs.dirname(vim.fs.find('selene.toml', { upward = true, path = vim.api.nvim_buf_get_name(0) })[1])
          end,
        },

        -- python
        null_ls.builtins.formatting.black,
      },
    }
  end,
  event = 'VeryLazy',
}
