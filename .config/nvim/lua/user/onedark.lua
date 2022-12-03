require('onedark').setup {
  -- Main options --
  style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {
    bg0 = "#212121",
    bg1 = "#181818",
  }, -- Override default colors

  highlights = {
    ["@variable"] = { fg = '#EEFFFF' },
    ["@field"] = { fg = '#EEFFFF' },
    ["@parameter"] = { fg = '#F78C6c' },
    ["@string"] = { fg = '#C3E88D' },
    ["@constructor"] = { fg = '#82AAFF', fmt = 'none' },
    ["@function.call"] = { fg = '#82AAFF', fmt = 'none' },
    ["@constant.builtin"] = { fg = '#82AAFF', fmt = 'italic' },
    ["@string.escape"] = { fg = '#89DDFF', fmt = 'none' },
    ["@number"] = { fg = '#F78C6c', fmt = 'none' },
    ["@HlargsNamedParams"] = { fg = '#F78C6c', fmt = 'none' },
    ["@type"] = { fg = '#FFCB6B', fmt = 'none' },
    ["@include"] = { fg = '#89DDFF', fmt = 'italic' },
    ["@bracket"] = { fg = '#EEFFFF' },
    ["Folded"] = { fg = '#212121', bg = '#212121' },
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}

require('onedark').load()
