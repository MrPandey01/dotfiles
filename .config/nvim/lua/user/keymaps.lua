local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- mappings with leader key are defined in whichkey.lua
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- explorer window
keymap("n", "<F3>", ":NvimTreeToggle<CR>", opts)


-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Clear search results with //
keymap('n', '//', ':noh<CR>', opts)

-- Move to beginning and end of line from home row
-- in both normal and visual mode
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)
keymap('v', 'H', '^', opts)
keymap('v', 'L', '$', opts)

-- For escaping
--[[ keymap("i", "kk", "<ESC>", opts) ]]
--[[ keymap("i", "jj", "<ESC>", opts) ]]
--[[ keymap("i", "hh", "<ESC>", opts) ]]

-- For navigation (treat line breaks as new lines)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)


-- For Changing
keymap("n", "cw", "ciw", opts)
keymap("n", "c(", "ci(", opts)
keymap("n", "c{", "ci{", opts)
keymap("n", "c[", "ci[", opts)
keymap("n", "c'", "ci'", opts)
keymap("n", 'c"', 'ci"', opts)


-- For Yanking
keymap("n", "yw", "yiw", opts)
keymap("n", "y(", "yi(", opts)
keymap("n", "y{", "yi{", opts)
keymap("n", "y[", "yi[", opts)
keymap("n", "y'", "yi'", opts)
keymap("n", 'y"', 'yi"', opts)


-- For Deleting
keymap("n", "dw", "daw", opts)
keymap("n", "d(", "da(", opts)
keymap("n", "d{", "da{", opts)
keymap("n", "d[", "da[", opts)
keymap("n", "d'", "da'", opts)
keymap("n", 'd"', 'da"', opts)


-- For Selecting
keymap("n", "vw", "viw", opts)
keymap("n", "v(", "vi(", opts)
keymap("n", "v{", "vi{", opts)
keymap("n", "v[", "vi[", opts)
keymap("n", "v'", "vi'", opts)
keymap("n", 'v"', 'vi"', opts)

-- For pasting
-- Original `p` command still works but with a time-delay
keymap("n", "pw", "\"_dawP", opts)
keymap("n", "p{", "\"_di{P", opts)
keymap("n", "p}", "\"_di}P", opts)
keymap("n", "p(", "\"_di(P", opts)
keymap("n", "p)", "\"_di)P", opts)
keymap("n", "p]", "\"_di]P", opts)
keymap("n", "p[", "\"_di[P", opts)
keymap("n", "p'", "\"_di'P", opts)
keymap("n", 'p"', '\"_di\"P', opts)
