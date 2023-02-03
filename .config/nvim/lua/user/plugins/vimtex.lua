--[[ local status_ok, vimtex = pcall(require, "vimtex") ]]
--[[ if not status_ok then ]]
--[[ 	vim.notify(vimtex, vim.log.levels.ERROR) ]]
--[[   return ]]
--[[ end ]]

-- Vimtex options ---------------------------------
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  cites = 1,
  fancy = 1,
  greek = 1,
  math_bounds = 1,
  math_delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 1,
  styles = 1,
}

vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_open_on_warning = 0

-- Disable custom warnings based on regexp
vim.g.vimtex_quickfix_ignore_filters = {
  ' Marginpar on page ',
  ' Underfull ',
  ' Overfull ',
  ' hyperref ',
  ' typearea ',
  ' Delete this space ',
  ' Non-breaking space ',
  ' Interword spacing ',
  ' Use either ',
  ' Delete this space ',
  ' You should ',
  ' Entry with key ',
}

vim.g.vimtex_view_general_viewer = 'qpdfview'
vim.g.vimtex_view_general_options = '--unique @pdf#src:@tex:@line:@col'
vim.g.vimtex_compiler_latexmk = {
  build_dir  = '',
  callback   = 1,
  continuous = 0,
  executable = 'latexmk',
  hooks      = {},
  options    = {
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
  --[[ options    = '-verbose -file-line-error -synctex=1 -interaction=nonstopmode', ]]
}
-- vim.g.vimtex_view_general_options_latexmk='--unique'
vim.g.vimtex_lint_chktex_ignore_warnings = '-n1 -n2 -n3 -n8 -n25 -n24 -n2'
vim.g.neomake_open_list = 0 -- Don't open neomake list automatically
