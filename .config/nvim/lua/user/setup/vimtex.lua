return {
  'lervag/vimtex',
  init = function()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'dist',
    }
    vim.g.vimtex_quickfix_enabled = 0
    vim.g.vimtex_fold_enabled = 1
    vim.g.vimtex_doc_handlers = { 'vimtex#doc#handlers#texdoc' }
    vim.g.vimtex_doc_confirm_single = false
    vim.g.vimtex_parser_bib_backend = 'lua'
  end,
}
