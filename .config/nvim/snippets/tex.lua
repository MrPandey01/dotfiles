-- This is the `get_visual` function.
-- See https://www.ejmastnak.com/tutorials/vim-latex/luasnip.html#tldr-hello-world-example
-- ----------------------------------------------------------------------------
-- Summary: If `SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- If `SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- ----------------------------------------------------------------------------

-- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env('tikzpicture')
end


return {
  -- Examples of complete snippets using fmt and fmta

  -- \texttt
  s({ trig = "tt", dscr = "Expands 'tt' into '\\texttt{}'" },
    fmta(
      "\\texttt{<>}",
      { i(1) }
    )
  ),
  -- \frac
  s({ trig = "ff", dscr = "Expands 'ff' into '\\frac{}{}'" },
    fmta(
      "\\frac{<>}{<>}",
      {
        i(1),
        i(2)
      },
    ),
    { condition = tex_utils.in_mathzone }-- `condition` option passed in the snippet `opts` table
  ),
  -- Equation
  s({ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
      { i(1) }
    )
  ),
  s({ trig = "env", snippetType = "autosnippet", dscr = "creates environment" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]] ,
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
  -- Example use of insert node placeholder text
  s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  -- Example: italic font implementing visual selection
  s({ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      }
    )
  ),
}
