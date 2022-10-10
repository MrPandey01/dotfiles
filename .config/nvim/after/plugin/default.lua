--[[ vim.opt.foldlevel = 20 ]]
--[[ vim.opt.foldmethod = "expr" ]]
--[[ vim.opt.foldexpr = "nvim_treesitter#foldexpr()" ]]

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = true

