local opt = vim.opt

opt.shortmess:append { W = true, I = true, c = true }
opt.breakindent = true
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.cmdheight = 1
opt.completeopt = { "menu,menuone,preview,noinsert" } -- mostly just for cmp
opt.conceallevel = 0
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.foldcolumn = "1" -- '0' is not bad
opt.foldenable = true
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.joinspaces = false
opt.laststatus = 0
opt.list = true
opt.mouse = "a"
opt.pumblend = 10
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true
opt.scrollback = 100000
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.undofile = true
opt.updatetime = 200
-- opt.wildmode = "longest:full,full"
opt.backup = false -- creates a backup file
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.showtabline = 2 -- always show tabs
opt.swapfile = false -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.number = true -- set numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.textwidth = 80
opt.wrap = true -- display lines as one long line
opt.scrolloff = 999 -- is one of my fav
opt.sidescrolloff = 8
opt.guifont = "SauceCodePro Nerd Font Mono:h11" -- the font used in graphical neovim applications
opt.wildignore =
  "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.tmp,*.toc,*.aux,*.log,*.bbl,*.blg,*.log,*.lof,*.lot,*.ilg,*.out,*.glo,*.gls,*.nlo,*.nls,*.brf,*.ist,*.glg,*.synctex.gz,*.tgz,*.idx,*.ind,*blx.bib,*.fdb_latexmk,*.run.xml,*.bcf,*.glsdefs,*.fls,*.eps,*.pdf,*.png,*.jpg" -- Show only files editable by vim
opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"
opt.formatoptions = "jcroqlnt" -- tcqj

if vim.fn.has "nvim-0.9.0" == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append { C = true }
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Spell check settings
vim.o.spelllang = "en_us"
vim.o.spelloptions = "camel"
vim.g.tex_comment_nospell = 1

-- nvim-tree specific setting
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
