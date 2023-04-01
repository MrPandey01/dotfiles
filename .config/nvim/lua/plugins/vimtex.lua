return {
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function()
      -- requires ~/.latexmkrc for nomenclature, glossary generation
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
      }
      -- vim.g.vimtex_view_general_options_latexmk='--unique'
      vim.g.vimtex_lint_chktex_ignore_warnings = '-n1 -n2 -n3 -n8 -n25 -n24 -n2'
      vim.g.neomake_open_list = 0 -- Don't open neomake list automatically
    end
  }
}
