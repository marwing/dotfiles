local ok, tsconfig = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

tsconfig.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "cmake", "vim", "latex" },
    additional_vim_regex_highlighting = false,
  },
}
