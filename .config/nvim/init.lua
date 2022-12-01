require("user.plugins")
require("impatient") -- Improves Startup Performance

require("user.options")
require("user.keymaps")

require("user.treesitter")
require("user.lsp") -- lsp including cmp, snippets

require("user.whichkey") -- keymaps


require("user.dap") -- debug

require("user.vista") -- tags
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree") -- file explorer
require("user.alpha")
require("user.autosave")
require("user.remember") -- remembers last cursor position
require("user.ufo")
require("user.auto-session")
require("project_nvim").setup()

require("user.vimtex")

require('leap').add_default_mappings()
require('flit').setup()

-- UI
require("user.bufferline")
require("user.indentline")
require("user.lualine")

require('neoscroll').setup() -- smooth scrolling

require('telescope').load_extension('luasnip')
require('telescope').load_extension('projects')

-- colorscheme (keep last to over-ride default colors)
require('hlargs').setup()
require('colorizer').setup()
require("user.onedark")

