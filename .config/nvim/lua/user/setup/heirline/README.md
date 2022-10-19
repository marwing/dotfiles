# Heirline Config

This is a very WIP statusline config

## TODOs
### default statusline
- [ ] Scrollbar
- [ ] Proper position
- [ ] 3 part filename? (path to pwd, path from pwd, filename)
- [ ] icon fileformat?
- [ ] colored language servers
- [ ] hide/shrink some components when space is tight (make_flexible_component, width_percent_below)
- [x] missing with cmdheight=0
  - [x] amount visual lines selected
  - [x] macro recording

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
- [x] filetype
- [x] vimtex
- [x] encoding
- [x] fileformat
- [x] searchcount
- [x] obsession
- [x] wordcount
- [x] fileprogress

Extensions:
- [ ] fugitive
- [x] neo-tree
- [ ] quickfix
- [x] vimcmake

### airline
Implement everything useful from airline that I didn't get to implement in lualine
```vim
let g:airline_extensions = ["branch", "fugitiveline", "hunks", "nvimlsp", "obsession", "quickfix", "searchcount", "tabline", "tagbar", "term", "vimcmake", "vimtex", "whitespace", "wordcount"]
```
- [ ] fugitiveline
- [ ] tabline
- [x] tagbar
- [ ] term
- [x] vimcmake
- [ ] whitespace
