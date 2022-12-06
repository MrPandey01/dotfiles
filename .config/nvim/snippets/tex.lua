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
local tex = {}
tex.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end


return {
  parse({ trig = "ip", wordTrig = true, snippetType = 'autosnippet', dscr = 'Inner product' },
    "\\langle $1 \\rangle"),

  parse({ trig = "fr", wordTrig = true, snippetType = 'autosnippet', dscr = '\frac{}{}' },
    "\\frac{$1}{$2}"),

  parse({ trig = "beg", wordTrig = true, dscr = 'begin env' },
    "\\begin{$1} \n \t${2:$SELECT_DEDENT} \n \\end{$1}"),

  parse({ trig = "beq", wordTrig = true, dscr = 'begin equation' },
    "\\begin{equation*}\n\t${1:$SELECT_DEDENT}\n\\end{equation*}"),

  parse({ trig = "bal", wordTrig = true, dscr = 'begin aligned' },
    "\\begin{aligned}\n\t${1:$SELECT_DEDENT}\n\\end{aligned}"),

  parse({ trig = "bfr", wordTrig = true, dscr = 'begin frame' },
    "\\begin{frame}\n\\frametitle{$1}\n$2\n\\end{frame}"),

  parse({ trig = "bite", wordTrig = true, dscr = 'begin itemize' },
    "\\begin{itemize} \n \\item {$1} \n \\end{itemize}"),

  parse({ trig = "lra", wordTrig = true },
    "\\leftrightarrow"),

  parse({ trig = "Lra", wordTrig = true },
    "\\Leftrightarrow"),

  parse({ trig = "tr", wordTrig = true },
    "\\item $1"),

  parse({ trig = "abs", wordTrig = true },
    "\\lvert ${1:$SELECT_DEDENT} \\rvert"),

  parse({ trig = "*", wordTrig = true },
    "\\cdot "),

  parse({ trig = "sum", wordTrig = true },
    [[\sum^{$1}_{$2}]]),

  parse({ trig = "sum", wordTrig = true },
    [[\sum^{$1}_{$2}]]),

  parse({ trig = "int", wordTrig = true },
    [[\int_{${1:lower}}^{${2:upper}} $3 \\,d$4]]),


  s({ trig = "tt", dscr = "Expands 'tt' into '\\texttt{}'" },
    fmta(
      "\\texttt{<>}",
      { i(1) }
    )
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
  s({ trig = "env", autoexpand = true, dscr = "creates environment" },
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
