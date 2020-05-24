
set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


" Obscure hacks done, you can now modify the rest of the config down below 
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin("~/.vim/plugged")

" Now the actual plugins:

Plug 'arielrossanigo/dir-configs-override.vim' " Override configs by directory

Plug 'tpope/vim-obsession' " :mksession alternative

Plug 'preservim/nerdcommenter'

Plug 'vim-scripts/IndexedSearch'  " Search results counter

" A couple of nice color schemes
"Plug 'patstockwell/vim-monokai-tasty'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal'
Plug 'kaicataldo/material.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Townk/vim-autoclose' " Automatically close parenthesis, etc

" Surround
Plug 'tpope/vim-surround'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Deoplete: on the fly completion suggestions
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

Plug 'lervag/vimtex' " Latex plugin

" Track the engine.
Plug 'SirVer/ultisnips'
"
" " Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
"
Plug 'ryanoasis/vim-devicons'
" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
 
if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    set nocompatible
    filetype plugin indent on
    set ls=2  " always show statusbar
    set incsearch  " Incremental search
    set hlsearch  " highlight search results
    syntax on
    set cursorline
    set mouse=a
    set spell spelllang=en_us
    set background=dark

    " global color settings
    "if (has('termguicolors'))
      "set termguicolors
    "endif
    " clipboard
    "
    " Use the OS clipboard by default (on versions compiled with `+clipboard`)
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif

    " reopen the file at same cursor location
    if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
    endif

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    "set directory=~/.vim/dirs/tmp     " directory to place swap files in
    "set backup                        " make backup files
    "set backupdir=~/.vim/dirs/backups " where to put backup files
    "set undofile                      " persistent undos - undo after you re-open the file
    "set undodir=~/.vim/dirs/undos
    "set viminfo+=n~/.vim/dirs/viminfo
     "create needed directories if they don't exist
    "if !isdirectory(&backupdir)
        "call mkdir(&backupdir, "p")
    "endif
    "if !isdirectory(&directory)
        "call mkdir(&directory, "p")
    "endif
    "if !isdirectory(&undodir)
        "call mkdir(&undodir, "p")
    "endif
end

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    let t_Co = 256

    " gruvbox settings
    let g:gruvbox_italic = '1'
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox

    " Material theme settings
    "let g:material_theme_style = 'default' " default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
    "let g:material_terminal_italics = 1
    "colorscheme material

    " Settings for arcticnord theme
    "let g:nord_cursor_line_number_background = 1
    "let g:nord_bold = 0
    "colorscheme nord

else
    colorscheme delek
endif

" needed so deoplete can auto select the first suggestion
" set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" Autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmenu
set wildignore+=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class,*/*.dSYM/*,*.dylib,*.so,*.swp,*.zip,*.tgz,*.gz
set wildmode=list,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/zsh

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Deoplete -----------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
"let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'


" Window Chooser ------------------------------
" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1


" Autoclose ------------------------------
" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Vimtex ---------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

" UltiSnippets ---------------------------
" Snippets Trigger configuration. 
" Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<shift+tab>"

let g:UltiSnipsEditSplit="vertical""

" NerdCommenter ------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

nnoremap <C-T> :call NERDComment(0,"toggle")<CR>
vnoremap <C-T> :call NERDComment(0,"toggle")<CR>

" Custom configurations ----------------
" Disable arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" copy-paste to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

imap jj <Esc>
imap kk <Esc>
imap jk <Esc>

nnoremap cw ciw
nnoremap dw diw
nnoremap c( ci(
nnoremap c' ci'
nnoremap c" ci"
xnoremap p pgvy

set splitbelow
set splitright

" SplitScreen navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" alternate of :w is :update i.e write only when there is change
" in document
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi

" Autocorrect spelling mistake on-the-fly
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Statusline options
set statusline=%{ObsessionStatus()}

" Set F5 to save and run the current python file
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>


" Include user's custom vim configurations
let custom_configs_path = "~/.vim/custom.vim"
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif
