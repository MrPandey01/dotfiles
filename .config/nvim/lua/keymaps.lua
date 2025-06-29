local opts = { noremap = true, silent = true, nowait = true }

-- Shorten function name
local keymap = vim.keymap.set

-- easy write
keymap('n', '<leader>w', '<cmd>w<cr>', opts)

-- easy quite
vim.keymap.set('n', '<leader>qq', function()
  vim.cmd 'ToggleTermToggleAll' -- Close all ToggleTerm terminals
  vim.cmd 'qa' -- Quit all windows
end, { noremap = true, silent = true })

-- paste in insert mode
-- keymap('i', '<c-v>', '<C-o>"+P<C-o>=\']', opts)

-- selects pasted text in visual mode
keymap('n', 'gp', '`[v`]', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Clear search results with // or esc
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap('n', '//', '<cmd>nohlsearch<CR>')

-- Move to beginning and end of line from home row
-- in both normal and visual mode
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)
keymap('v', 'H', '^', opts)
keymap('v', 'L', '$', opts)

-- For Changing
keymap('n', 'cw', 'ciw', opts)
keymap('n', 'cW', 'ciW', opts)
keymap('n', 'c(', 'ci(', opts)
keymap('n', 'c{', 'ci{', opts)
keymap('n', 'c[', 'ci[', opts)
keymap('n', "c'", "ci'", opts)
keymap('n', 'c"', 'ci"', opts)

-- For Yanking
keymap('n', 'yw', 'yiw', opts)
keymap('n', 'yW', 'yiW', opts)
keymap('n', 'y(', 'yi(', opts)
keymap('n', 'y{', 'yi{', opts)
keymap('n', 'y[', 'yi[', opts)
keymap('n', "y'", "yi'", opts)
keymap('n', 'y"', 'yi"', opts)
keymap('n', 'Y', 'y$', opts) -- consistent with C & D

-- For Deleting
keymap('n', 'dw', 'daw', opts)
keymap('n', 'dW', 'daW', opts)
keymap('n', 'd(', 'da(', opts)
keymap('n', 'd{', 'da{', opts)
keymap('n', 'd[', 'da[', opts)
keymap('n', "d'", "da'", opts)
keymap('n', 'd"', 'da"', opts)

-- For Selecting
keymap('n', 'vw', 'viw', opts)
keymap('n', 'vW', 'viW', opts)
keymap('n', 'v(', 'vi(', opts)
keymap('n', 'v{', 'vi{', opts)
keymap('n', 'v[', 'vi[', opts)
keymap('n', "v'", "vi'", opts)
keymap('n', 'v"', 'vi"', opts)

-- Diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal keybindings
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
keymap('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- buffers
keymap('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- save file
keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- lazy
keymap('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
keymap('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
keymap('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
keymap('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
keymap('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
keymap('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
keymap('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
keymap('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
