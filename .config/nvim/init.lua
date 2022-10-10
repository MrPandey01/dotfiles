require("user.plugins")
require("impatient") -- Improves Startup Performance

require("user.options")
require("user.keymaps")

require("user.whichkey")  -- keymaps

require("user.lsp")  -- lsp including cmp

require("user.dap")  -- debug
require("user.treesitter")
require("user.vista")  -- tags
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")  -- file explorer
require("user.alpha")
require("user.autosave")
require("user.remember")  -- remembers last cursor position
require("user.slime")
require("user.ufo")

require("user.vimtex")

-- UI
require("user.bufferline")
require("user.indentline")
require("user.lualine")
require("user.material")  -- colorscheme

require('telescope').load_extension('luasnip')
