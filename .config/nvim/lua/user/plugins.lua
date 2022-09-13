local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
---@diagnostic disable-next-line: missing-parameter
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- stylua: ignore
  packer_bootstrap = vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd.packadd('packer.nvim')
end

require('packer').startup {
  function(use)
    -- packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- theme
    use {
      'gruvbox-community/gruvbox',
      config = function()
        require('user.setup.gruvbox')
      end,
    }

    -- syntax
    use { 'HerringtonDarkholme/yats.vim' }
    use { 'MaxMEllon/vim-jsx-pretty' }
    use { 'terminalnode/sway-vim-syntax' }

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('user.setup.lualine')
      end,
    }

    -- git integration
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('user.setup.gitsigns')
      end,
    }
    use {
      'tpope/vim-fugitive',
      requires = {
        'tpope/vim-rhubarb',
        'shumphrey/fugitive-gitlab.vim',
      },
    }
    use { 'rhysd/committia.vim' }

    -- completion & snipppets
    use {
      'L3MON4D3/LuaSnip',
      requires = 'honza/vim-snippets',
      config = function()
        require('user.setup.luasnip')
      end,
      ft = 'snippets',
      event = 'InsertEnter',
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'L3MON4D3/LuaSnip',
        'onsails/lspkind.nvim',
        { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp', 'LuaSnip' } },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'ray-x/cmp-treesitter', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      },
      config = function()
        require('user.setup.nvim-cmp')
      end,
      event = { 'InsertEnter', 'CmdlineEnter' },
    }

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        if vim.fn.exists(':TSUpdate') == 2 then
          vim.cmd('TSUpdate')
        end
      end,
      requires = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
        { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
      },
      config = function()
        require('user.setup.nvim-treesitter')
      end,
    }

    -- lsp
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('user.setup.lsp.lspconfig')
      end,
    }
    use {
      'folke/lua-dev.nvim',
      requires = 'neovim/nvim-lspconfig',
      config = function()
        require('user.setup.lsp.lua-dev')
      end,
    }
    use {
      'p00f/clangd_extensions.nvim',
      requires = 'neovim/nvim-lspconfig',
      config = function()
        require('user.setup.lsp.clangd_extensions')
      end,
    }
    use {
      'simrat39/rust-tools.nvim',
      requires = 'neovim/nvim-lspconfig',
      config = function()
        require('user.setup.lsp.rust-tools')
      end,
    }
    use {
      'ray-x/lsp_signature.nvim',
      config = function()
        require('user.setup.lsp_signature')
      end,
    }
    use {
      'j-hui/fidget.nvim',
      config = function()
        require('user.setup.fidget')
      end,
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('user.setup.lsp.null-ls')
      end,
    }
    use { 'b0o/schemastore.nvim' }

    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
        },
        'gbrlsnchs/telescope-lsp-handlers.nvim',
      },
      config = function()
        require('user.setup.telescope').config()
      end,
      setup = function()
        require('user.setup.telescope').setup()
      end,
      -- Figure out how to lazy load telescope and still use lsp_handlers
      -- cmd = 'Telescope',
      -- module = 'telescope',
    }

    -- misc
    use { 'lewis6991/impatient.nvim' } -- improve startup time for neovim
    use { 'tpope/vim-repeat' } -- repeatable plugin actions
    use { 'tpope/vim-obsession' } -- easier session management
    use { -- startup screen
      'mhinz/vim-startify',
      requires = 'kyazdani42/nvim-web-devicons',
      setup = function()
        require('user.setup.startify')
      end,
    }
    use { 'editorconfig/editorconfig-vim' } -- support for editorconfig files
    use { 'tpope/vim-sleuth' } -- heuristically set buffer options
    use { 'tpope/vim-surround' } -- surrounding text
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('user.setup.autopairs')
      end,
    }
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup({}, {
          css = true,
        })
      end,
      cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
    }
    use { -- display file tags in sidebar
      'preservim/tagbar',
      cmd = 'TagbarToggle',
    }
    use {
      'folke/zen-mode.nvim',
      requires = {
        {
          'folke/twilight.nvim',
          config = function()
            require('user.setup.twilight')
          end,
          opt = true,
        },
      },
      wants = 'twilight.nvim',
      config = function()
        require('user.setup.zen-mode')
      end,
      cmd = 'ZenMode',
    }
    use {
      'nvim-neo-tree/neo-tree.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('user.setup.neo-tree').config()
      end,
      setup = function()
        require('user.setup.neo-tree').setup()
      end,
      cmd = 'Neotree',
      ft = 'netrw',
    }
    use { -- smart commenting
      'numToStr/Comment.nvim',
      config = function()
        require('user.setup.Comment')
      end,
    }
    use { -- nicer ui for vim.ui.input and vim.ui.select
      'stevearc/dressing.nvim',
      requires = 'MunifTanjim/nui.nvim',
      config = function()
        require('user.setup.dressing')
      end,
    }
    use { -- nicer ui for vim.notify
      'rcarriga/nvim-notify',
      config = function()
        require('user.setup.notify')
      end,
    }
    use {
      'cdelledonne/vim-cmake',
      setup = function()
        require('user.setup.vim-cmake')
      end,
    }

    -- LaTeX
    use {
      'lervag/vimtex',
      setup = function()
        require('user.setup.vimtex')
      end,
    }

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      setup = function()
        require('user.setup.markdown-preview')
      end,
      ft = 'markdown',
    }
    use {
      'dhruvasagar/vim-table-mode',
      cmd = 'TableModeToggle',
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    preview_updates = true,
    display = {
      compact = true,
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = true,
    },
  },
}

local group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
})
