return {
  {
    'terminalnode/sway-vim-syntax',
    ft = 'swayconfig',
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
      { '<leader>bd', function() require'bufdelete'.bufdelete(0) end,  desc = 'bufdelete' },
      { '<leader>bw', function() require'bufdelete'.bufwipeout(0) end, desc = 'bufwipeout' },
    },
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
    },
  },
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
    'dhruvasagar/vim-table-mode',
    cmd = 'TableModeToggle',
  },
}
