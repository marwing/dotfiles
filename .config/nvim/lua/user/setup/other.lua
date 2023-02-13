return {
  -- syntax
  { 'HerringtonDarkholme/yats.vim' },
  { 'MaxMEllon/vim-jsx-pretty' },
  {
    'terminalnode/sway-vim-syntax',
    ft = 'swayconfig',
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
      'shumphrey/fugitive-gitlab.vim',
    },
    event = 'VeryLazy',
  },
  { 'rhysd/committia.vim' },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-obsession',
    cmd = 'Obsession',
    event = 'SessionLoadPost',
  },
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
    -- stylua: ignore
    keys = {
      { '<leader>bd', function() require'bufdelete'.bufdelete(0) end },
      { '<leader>bw', function() require'bufdelete'.bufwipeout(0) end },
    },
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
    },
  },
  { 'tpope/vim-sleuth' },
  {
    'tpope/vim-surround',
    event = 'VeryLazy',
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({}, {
        css = true,
      })
    end,
    cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    event = 'VeryLazy',
  },
  {
    'dhruvasagar/vim-table-mode',
    cmd = 'TableModeToggle',
  },
}
