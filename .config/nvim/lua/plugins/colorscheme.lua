return {
  {
    'navarasu/onedark.nvim',
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup { -- Main options --
        style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        term_colors = true, -- Change terminal color as per the selected theme style

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'italic',
          strings = 'none',
          variables = 'none',
        },

        -- Custom Highlights --
        colors = {
          -- bg0 = "#181818",101010
          bg0 = '#141414',
          -- bg1 = "#37373d",
        }, -- Override default colors

        highlights = {
          ['@variable'] = { fg = '#E8FFFB' },
          ['@lsp.type.variable'] = { fg = '#E8FFFB' },
          ['@field'] = { fg = '#E8FFFB' },
          -- ["@parameter"] = { fg = "#fc9878" },
          -- ["@lsp.type.namespace"] = { fg = "#3bc9a4" },

          ['@variable.builtin'] = { fg = '#d25d69' },
          ['@variable.parameter'] = { fg = '#F78C6c' },
          ['@lsp.type.parameter'] = { fg = '#F78C6c' },
          ['@keyword.import'] = { fg = '#a286c1' },
          ['@string'] = { fg = '#C3E88D' },
          ['@string.documentation.python'] = { fg = '#4c515c' },
          ['@constructor'] = { fg = '#82AAFF', fmt = 'none' },
          ['@function.call'] = { fg = '#82AAFF', fmt = 'none' },
          ['@function'] = { fg = '#82AAFF', fmt = 'none' },
          ['@constant.builtin'] = { fg = '#82AAFF', fmt = 'italic' },
          ['@string.escape'] = { fg = '#89DDFF', fmt = 'none' },
          -- ["@number"] = { fg = "#F78C6c", fmt = "none" },
          -- ["@HlargsNamedParams"] = { fg = "#F78C6c", fmt = "none" },
          ['@type'] = { fg = '#FFCB6B', fmt = 'none' },
          ['@include'] = { fg = '#89DDFF', fmt = 'italic' },
          -- ["Folded"] = { fg = "#212121", bg = "#212121" },
          ['MatchParen'] = { bg = nil, fmt = 'underline,bold' },
          ['texArg'] = { fg = '#E8FFFB' },
          ['Normal'] = { fg = '#E8FFFB' },
          ['@punctuation.bracket'] = { fg = '#e3ff0b' },

          -- Python specific
          -- ["@string.documentation.python"] = { fg = "#6a9955" },
          -- ["@string.python"] = { fg = "#ce9178"},
          -- ["@comment.python"] = { fg = "#6a9955" },
          -- ["@variable.python"] = { fg = "#9cdcfe" },
          -- ["@variable.member.python"] = { fg = "#9cdcfe" },
          -- ["@type.python"] = { fg = "#4ebc85" },
          -- ["@keyword.import.python"] = { fg = "#9579c0" },

          -- lua specific
          -- ["@comment.lua"] = { fg = "#6a9955" },
          -- ["@variable.member.lua"] = { fg = "#E8FFFB" },

          -- yaml
          -- ["@property.yaml"] = { fg = "#F78C6c", fmt = "none" },
          -- ["@number.yaml"] = { fg = "#9cdcfe", fmt = "none" },
          -- ["@boolean.yaml"] = { fg = "#82AAFF", fmt = "none" },
        },

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
