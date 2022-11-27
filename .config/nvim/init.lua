require("user.plugins")
require("impatient") -- Improves Startup Performance

require("user.options")
require("user.keymaps")

require("user.whichkey") -- keymaps

require("user.lsp") -- lsp including cmp

require("user.dap") -- debug
require("user.treesitter")
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

-- colorscheme
require("user.onedark")
require('hlargs').setup()

require("custom-theme").setup()
require('colorizer').setup()

-- UI
require("user.bufferline")
require("user.indentline")
require("user.lualine")



require('neoscroll').setup() -- smooth scrolling

require('telescope').load_extension('luasnip')
require('telescope').load_extension('projects')
