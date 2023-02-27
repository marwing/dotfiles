local function lazy_lsp_handlers()
  -- These are the methods that telescope-lsp-handlers sets handlers for.
  -- They should get updated when necessary
  local handlers = {
    'textDocument/declaration',
    'textDocument/definition',
    'textDocument/implementation',
    'textDocument/typeDefinition',
    'textDocument/references',
    'textDocument/documentSymbol',
    'workspace/symbol',
    'callHierarchy/incomingCalls',
    'callHierarchy/outgoingCalls',
    'textDocument/codeAction',
  }

  for _, req in ipairs(handlers) do
    vim.lsp.handlers[req] = function(...)
      require('lazy').load { plugins = { 'telescope.nvim' } }
      return vim.lsp.handlers[req](...)
    end
  end
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'gbrlsnchs/telescope-lsp-handlers.nvim',
  },
  init = lazy_lsp_handlers,
  config = function()
    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers')

    -- nvim-notify loads it's telescope extension automatically when it is first used after telescope
    -- this is only necessary to load the extension if telescope is loaded after nvim-notify
    if package.loaded['notify'] then
      telescope.load_extension('notify')
    end
  end,
  -- stylua: ignore
  keys = {
    { '<leader>fb', function() require('telescope.builtin').builtin() end, desc = 'Telescope builtin' },
    { '<leader>fr', function() require('telescope.builtin').resume() end, desc = 'Telescope resume' },
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find_files' },
    { '<leader>fl', function() require('telescope.builtin').buffers { sort_lastused = true } end, desc = 'Telescope buffers' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live_grep' },
    { '<leader>fo', function() require('telescope.builtin').oldfiles() end, desc = 'Telescope old_files' },
  },
}
