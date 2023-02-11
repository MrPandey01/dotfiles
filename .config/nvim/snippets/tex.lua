-- ----------------------------------------------------------------------------
-- See https://www.ejmastnak.com/tutorials/vim-latex/luasnip.html#tldr-hello-world-example
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
tex_utils.in_mathzone = function()
  --[[ return vim.fn['vimtex#syntax#in_mathzone']() == 1 ]]
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

tex_utils.in_env = function(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

tex_utils.in_tikz = function()
  return tex_utils.in_env("tikzpicture")
end

tex_utils.in_itemize = function()
  return tex_utils.in_env("itemize")
end

tex_utils.in_enumerate = function()
  return tex_utils.in_env("enumerate")
end

-- ----------------------------------------------------------------------------
return {

  s({ trig = "ip", wordTrig = true, snippetType = 'autosnippet', dscr = 'Inner product' },
    fmta(
      "\\langle <>, <> \\rangle <>",
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "fra", wordTrig = true, snippetType = 'autosnippet', dscr = '\frac{}{}' },
    fmta(
      "\\frac{<>}{<>} <>",
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "top", wordTrig = true, snippetType = 'autosnippet', dscr = '^\top' },
    fmta(
      "^\\top <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  parse({ trig = "$",
    wordTrig = true,
    snippetType = 'autosnippet',
    dscr = 'in-line math' },
    "$ $1 $ $0"),

  parse({ trig = "...", wordTrig = true, snippetType = 'autosnippet', dscr = '\\ldots' }, "\\ldots $0"),


  s({ trig = "^", wordTrig = true, snippetType = 'autosnippet', dscr = 'superscript box' },
    fmta(
      "^{<>} <>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "_", wordTrig = true, snippetType = 'autosnippet', dscr = 'subscript box' },
    fmta(
      "_{<>} <>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "mbr", wordTrig = true, snippetType = 'autosnippet', dscr = '\\mathbf{R}{$1}' },
    fmta(
      "\\mathbb{R}^{<>} <>",
      { i(1),
        i(0) }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  parse({ trig = "bitemize", wordTrig = true, dscr = 'begin itemize' },
    "\\begin{itemize} % default \\setlength\\itemsep{0em} \n \\item $1 \n \\end{itemize}"),

  s({ trig = "it", wordTrig = true, snippetType = 'autosnippet', dscr = '\\item' },
    fmta(
      "\\item <>",
      { i(0), }
    ),
    { condition =  tex_utils.in_itemize,
      show_condition = tex_utils.in_itemize }
  ),

  parse({ trig = "beg", wordTrig = true, dscr = 'begin env' },
    "\\begin{${1:ENV_NAME}} \n \t${2:$SELECT_DEDENT} \n \\end{$1}"),

  parse({ trig = "section", wordTrig = true, dscr = 'section' },
    "\\section{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "subsection", wordTrig = true, dscr = 'subsection' },
    "\\subsection{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "subsubsection", wordTrig = true, dscr = 'subsubsection' },
    "\\subsubsection{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "paragraph", wordTrig = true, dscr = 'paragraph' },
    "\\paragraph{${1:NAME}} \n $1"),


  parse({ trig = "bequation", wordTrig = true, dscr = 'begin equation' },
    "\\begin{equation*}\n\t${1:$SELECT_DEDENT}\n\\end{equation*}"),

  parse({ trig = "baligned", wordTrig = true, dscr = 'begin aligned' },
    "\\begin{aligned} \n \t${1:$SELECT_DEDENT} \n \\end{aligned}"),

  parse({ trig = "bframe", wordTrig = true, dscr = 'begin frame' },
    "% Begin FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n \
    \\begin{frame} \n \\frametitle{$1} \n $2 \n \\end{frame}"),

  parse({ trig = "benumerate", wordTrig = true, dscr = 'begin enumerate' },
    " \\begin{enumerate} \n \
      \\item  ${1} \n \
      \\end{enumerate}"),

  s({ trig = "it", wordTrig = true, snippetType = 'autosnippet', dscr = '\\item' },
    fmta(
      "\\item <>",
      { i(0), }
    ),
    { condition =  tex_utils.in_enumerate,
      show_condition = tex_utils.in_enumerate }
  ),

  parse({ trig = "bmatrix", wordTrig = true, dscr = 'begin matrix' },
    " \\begin{bmatrix} \n \
        $1 & $2 \\\\ \
        $3 & $4 \
      \\end{bmatrix}"),

  parse({ trig = "float_img", wordTrig = true, dscr = 'tikz float_img' },
    " \\tikz[remember picture, overlay] \\node[anchor=center] \
      (img) at ($(current page.center)+(0,0)$) \
      {\\includegraphics[width=3.5cm]{$1}}; \n \
      \\tikz[remember picture, overlay] \\node (caption)\
      [below of=img, yshift=-0.6cm, xshift=0cm] {$0}; "),

  parse({ trig = "bfigure", wordTrig = true, dscr = 'begin figure' },
    " \\begin{figure}[${1:htpb}] \
        \\centering \
        ${2:\\includegraphics[width=0.8\\textwidth]{$3}} \
        \\caption{${4:${3}}} \
        \\label{fig:${5:${3}}} \
      \\end{figure} "),

  parse({ trig = "bsubfigure", wordTrig = true, dscr = 'begin subfigure' },
    " \\begin{figure}[${1:htpb}] \
         \\centering \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${2:fig1}} \
             \\caption{${3:$2}} \
             \\label{fig:${4:$2}} \
         \\end{subfigure} \
         \\hfill \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${5:fig2}} \
             \\caption{${6:$5}} \
             \\label{fig:${7:$5}} \
         \\end{subfigure} \
         \\hfill \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${8:fig3}} \
             \\caption{${9:$8}} \
             \\label{fig:${10:$8}} \
         \\end{subfigure} \
            \\caption{${11:Three simple graphs}} \
            \\label{fig:${12:three graphs}} \
    \\end{figure} "),

  parse({ trig = "norm", wordTrig = true },
    "\\lvert ${1:$SELECT_DEDENT} \\rvert"),

  parse({ trig = "*", wordTrig = true },
    "\\cdot "),

  parse({ trig = "sum", wordTrig = true },
    [[\sum^{$1}_{$2}]]),

  parse({ trig = "int", wordTrig = true },
    [[\int_{${1:lower}}^{${2:upper}} $3 \\,d$4]]),

  parse({ trig = "lim", wordTrig = true },
    [[\lim_{${1:lower}}^{${2:upper}} $3 \\,d$4]]),

  parse({ trig = "partial_derivative", wordTrig = true, dscr = 'partial derivative' },
    [[\frac{\partial ${1:f(x)}}{\partial ${2:x}} $0]]),

  s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),

  s({ trig = "emph", dscr = "\\emph{$VISUAL}" },
    fmta("\\emph{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "underline", dscr = "\\underline{$VISUAL}" },
    fmta("\\underline{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "textbf", dscr = "\\textbf{$VISUAL}" },
    fmta("\\textbf{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "bm", dscr = "bold math \\bm{$VISUAL}" },
    fmta("\\bm{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  -- Some Templates ------------------------------------------
  parse({ trig = "template_standalone", wordTrig = true, dscr = 'standalone figure' },
    " \
    \\documentclass[varwidth, border=0cm]{standalone} \
\
    \\usepackage[export]{adjustbox} \
    \\usepackage{graphicx} \
    \\usepackage{array} \
    \\usepackage{tabu} \
    \\usepackage{multirow} \
    \\usepackage{multicol} \
    \\usepackage{makecell} \
 \
    \\newcommand{\\tabfigure}[2]{\\raisebox{-.5\\height}{\\includegraphics[#1]{#2}}} \
 \
    \\begin{document} \
 \
    \\begin{figure} \
    \\centering \
    \\setlength\tabcolsep{0pt} \
    \\def\\arraystretch{0.0} %  1 is the default, change whatever you need \
    \\begin{tabu}{c} \
      \\tabfigure{height=1cm, width=1cm}{$0} \
    \\end{tabu} \
    \\end{figure} \
    \\end{document} \
  "),

  parse({ trig = "template_article", wordTrig = true, dscr = 'basic article' },
    " \
    \\documentclass[12pt]{article} \
    \
    \\title{TITLE} \
    \\author{someone} \
    \\date{\\today} \
    % sans-serif font \
    \\renewcommand{\\familydefault}{\\sfdefault} \
    \
    \\begin{document} \
    \\maketitle \
    \
    \\begin{abstract} \
    some abstract \
    \\end{abstract} \
    \
    \\section{Introduction} \
    This is time for all good men to come to the aid of their party\
    \
    \\bibliographystyle{abbrv}\
    \\bibliography{main}\
    \
    \\end{document} \
  "),

}
