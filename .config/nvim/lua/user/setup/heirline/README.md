# Heirline Config

This is a very WIP statusline config

## TODOs
### default statusline
- Scrollbar
- Proper position
- 3 part filename? (path to pwd, path from pwd, filename)
- icon fileformat?
- colored language servers
- hide/shrink some components when space is tight (make_flexible_component, width_percent_below)
- missing with cmdheight=0
  - amount visual lines selected
  - macro recording

### other statuslines
- special
- terminal

### lualine
Implement everything useful from my lualine config
```lua
require('lualine').setup {
  sections = {
    lualine_a = { 'mode', 'spell' },
    lualine_b = { 'branch', { 'diff', source = gitsigns_diff_source }, 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'lspclients', 'filetype' },
    lualine_y = { 'vimtex', 'encoding', 'fileformat', 'searchcount' },
    lualine_z = { 'obsession', 'wordcount', 'fileprogress' },
  },
  extensions = { 'fugitive', 'my-neo-tree', 'quickfix', 'vimcmake' },
}
```
Components:
- [x] mode
- [x] spell
- [x] branch
- [x] diff
- [x] diagnostics
- [x] filename
- [x] lspclients
- [ ] filetype
- [ ] vimtex
- [ ] encoding
- [ ] fileformat
- [x] searchcount
- [ ] obsession
- [ ] wordcount
- [ ] fileprogress

Extensions:
- [ ] fugitive
- [ ] neo-tree
- [ ] quickfix
- [ ] vimcmake

### airline
Implement everything useful from airline that I didn't get to implement in lualine
```vim
let g:airline_extensions = ["branch", "fugitiveline", "hunks", "nvimlsp", "obsession", "quickfix", "searchcount", "tabline", "tagbar", "term", "vimcmake", "vimtex", "whitespace", "wordcount"]
```
- [ ] fugitiveline
- [ ] tabline
- [ ] tagbar
- [ ] term
- [ ] vimcmake
- [ ] whitespace
