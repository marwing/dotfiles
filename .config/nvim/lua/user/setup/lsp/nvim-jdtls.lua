local function on_ft()
  -- TODO: multiplatform? stdpath()
  local workspace_root = vim.fn.expand('~/.cache/jdtls/')

  local root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml' }
  local data_dir = workspace_root .. vim.fn.fnamemodify(root_dir, ':p:h:t')

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = require('user.setup.lsp.overrides').default_params {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
      -- use jdtls wrapper script. Significantly simplifies setup
      'jdtls',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-data',
      data_dir,
    },

    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = 'JavaSE-1.8',
              path = '/usr/lib/jvm/java-8-openjdk',
            },
            {
              name = 'JavaSE-11',
              path = '/usr/lib/jvm/java-11-openjdk',
            },
            {
              name = 'JavaSE-17',
              path = '/usr/lib/jvm/java-17-openjdk',
            },
          },
        },
        format = {
          settings = {
            url = vim.fs.find('eclipse-formatter.xml', { upward = true, path = vim.api.nvim_buf_get_name(0) })[1],
          },
        },
      },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      -- TODO: auto install
      bundles = vim.list_extend({
        vim.fn.glob(
          vim.fn.stdpath('data')
            .. '/jdtls/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.42.0.jar',
          true
        ),
      }, vim.split(vim.fn.glob(vim.fn.stdpath('data') .. '/jdtls/vscode-java-test/server/*.jar', true), '\n')),
    },
  }

  require('jdtls').start_or_attach(config)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user_jdtls', { clear = true }),
  pattern = 'java',
  callback = on_ft,
  desc = 'Setup jdtls for current buffer',
})
