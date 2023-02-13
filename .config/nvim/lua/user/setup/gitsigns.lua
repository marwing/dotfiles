return {
  'lewis6991/gitsigns.nvim',
  opts = {
    worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. '/.dotfiles',
      },
    },
  },
  event = 'VeryLazy',
}
