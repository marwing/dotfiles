local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })

  -- hacky workaround
  -- see https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end
end

require('packer').startup({
  function(use)
    -- packer can manage itself
    use 'wbthomason/packer.nvim'

    -- theme
    use 'gruvbox-community/gruvbox'

    -- syntax
    use 'HerringtonDarkholme/yats.vim'
    use 'MaxMEllon/vim-jsx-pretty'
    use 'terminalnode/sway-vim-syntax'

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        'ryanoasis/vim-devicons', -- only used for custom encoding_fileformat component
      },
    }

    -- git integration
    use 'lewis6991/gitsigns.nvim'
    use {
      'tpope/vim-fugitive',
      requires = {
        'tpope/vim-rhubarb',
        'shumphrey/fugitive-gitlab.vim',
      },
    }
    use 'rhysd/committia.vim'

    -- completion & snipppets
    use {
      'L3MON4D3/LuaSnip',
      requires = 'honza/vim-snippets',
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'onsails/lspkind.nvim',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'ray-x/cmp-treesitter',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-emoji',
      },
    }

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'p00f/clangd_extensions.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'j-hui/fidget.nvim'

    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make'
        },
        'nvim-telescope/telescope-ui-select.nvim',
        'gbrlsnchs/telescope-lsp-handlers.nvim',
      },
    }

    -- misc
    use 'lewis6991/impatient.nvim' -- improve startup time for neovim
    use 'tpope/vim-repeat' -- repeatable plugin actions
    use 'tpope/vim-obsession' -- easier session management
    use 'mhinz/vim-startify' -- startup screen
    use 'editorconfig/editorconfig-vim' -- support for editorconfig files
    use 'tpope/vim-sleuth' -- heuristically set buffer options
    use 'tpope/vim-surround' -- surrounding text
    use 'jiangmiao/auto-pairs' -- auto close pairs of parens, quotes, etc
    use 'chrisbra/Colorizer' -- color hex codes and color names
    use 'preservim/tagbar' -- display file tags in sidebar
    use {
      'folke/zen-mode.nvim',
      requires = 'folke/twilight.nvim',
    }
    use {
      "nvim-neo-tree/neo-tree.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "kyazdani42/nvim-web-devicons",
      },
    }
    use 'numToStr/Comment.nvim' -- smart commenting
    use { -- nicer ui for vim.ui.input
      'stevearc/dressing.nvim',
      requires = "MunifTanjim/nui.nvim",
    }
    use 'rcarriga/nvim-notify' -- nicer ui for vim.notify
    use 'cdelledonne/vim-cmake'

    -- LaTeX
    use 'lervag/vimtex'

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
    }
    use 'dhruvasagar/vim-table-mode'

    if packer_bootstrap then
      require('packer').sync()
    end
  end, config = {
    display = {
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = true,
    },
  },
})

local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = 'plugins.lua',
  command = "source <afile> | PackerCompile"
})
