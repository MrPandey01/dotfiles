
set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization

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

" Manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
call plug#begin("~/.vim/plugged")
"
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Deoplete: on the fly completion suggestions
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'lervag/vimtex' " Latex plugin
Plug 'vimwiki/vimwiki'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Townk/vim-autoclose' " Automatically close parenthesis, etc
Plug 'ryanoasis/vim-devicons'  " Icons for NerdTree
Plug '907th/vim-auto-save'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/IndexedSearch'  " Search results counter

" color scheme
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map  messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
 
set nocompatible
filetype plugin indent on
set ls=2  " always show status bar
set incsearch  " Incremental search
set hlsearch  " highlight search results
syntax on
set cursorline
set mouse=a
set spell spelllang=en_us
set background=dark
set splitbelow
set splitright
set autochdir
set scrolloff=3
set shell=/bin/zsh
set display+=lastline
set conceallevel=2  " for better readability

" For hybrid line numbers
set number relativenumber
set nu rnu

" Tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Clear search results
nnoremap <silent> // :noh<CR>

" Remove ugly vertical lines on window division
set fillchars+=vert:\ 

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
else
    set clipboard=unnamed
endif

" Change cursor shape in different modes
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Reopen the file at same cursor location
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    let t_Co = 256

    " gruvbox settings
    " let g:gruvbox_italic = '1'
    " let g:gruvbox_contrast_dark = 'hard'
    " colorscheme gruvbox


    " Gruvbox material settings
    " Set contrast.
    " This configuration option should be placed before `colorscheme gruvbox-material`.
    " Available values: 'hard', 'medium'(default), 'soft'
    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_enable_italic = 1
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_palette = 'material'
    " let g:gruvbox_material_transparent_background = 1
    colorscheme gruvbox-material

else
    colorscheme delek
endif


" Autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmenu
set wildignore+=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class,*/*.dSYM/*,*.dylib,*.so,*.swp,*.zip,*.tgz,*.gz,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildmode=list,full


" Clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e


" ============================================================================
" Plugins settings and mappings

" NERDTree -----------------------------
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

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
" Complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Needed so deoplete can auto select the first suggestion
set completeopt+=noinsert

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
" set completeopt-=preview

" Auto-save settings ---------------------------
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_events = ["InsertLeave", "TextChanged"]


" Autoclose ------------------------------
" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}


" Vimtex ---------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif


" VimWiki --------------------------------
nmap <Leader>tl <Plug>VimwikiToggleListItem
vmap <Leader>tl <Plug>VimwikiToggleListItem
" let g:vimwiki_hl_cb_checked = 2


" UltiSnippets ---------------------------
" Snippets Trigger configuration. 
" Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<shift+tab>"
let g:UltiSnipsEditSplit="vertical""
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom_snippets"]


" NerdCommenter ------------------------
let g:NERDSpaceDelims = 1
" let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" Comment toggle with Ctrl-/
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>


" Key configurations ----------------
" Disable arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

imap jj <Esc>
imap hh <Esc>
imap kk <Esc>
imap jk <Esc>

" Copy remaps
nnoremap cw ciw
nnoremap c( ci(
nnoremap c{ ci{
nnoremap c' ci'
nnoremap c" ci"

" Delete remaps
nnoremap dw diw
nnoremap d" da"
nnoremap d' da'
nnoremap d( da(
nnoremap d{ da{

" Select remaps
nnoremap vw viw
nnoremap v" vi"
nnoremap v' vi'
nnoremap v( vi(
nnoremap v{ vi{

" SplitScreen navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Auto correct spelling mistake on-the-fly (with the first suggestion)
inoremap <C-c> <c-g>u<Esc>[s1z=`]a<c-g>u


" Sort and highlight ToDo list
" source: https://www.reddit.com/r/vim/comments/hc3m1w/how_to_sort_nested_todo_list/fvfw4lv?utm_source=share&utm_medium=web2x
nnoremap <leader>td :TodoSort<CR>
command! -range=% TodoSort call TodoSort(<line1>,<line2>)

fun! TodoSort(line1, line2)
  if indent(a:line1) | return | endif

  let Compare = { a, b -> a.line == b.line ? 0 : a.line < b.line ? -1 : 1 }
  let lines = []
  let stack = [lines]
  let previndent = 0

  for lnum in range(a:line1, a:line2)
    let indent = indent(lnum)
    if indent > previndent
       call add(stack, stack[-1][-1].children)
    elseif indent < previndent
      for _ in range((previndent - indent) / shiftwidth())
        call sort(stack[-1], Compare)
        call remove(stack, -1)
      endfor
    endif
    call add(stack[-1], { 'line': getline(lnum), 'children': [] })
    let previndent = indent
  endfor

  call sort(lines, Compare)

  fun! Flatten(lines, ...)
    let out = a:0 ? a:1 : []
    for line in a:lines
      call add(out, line.line)
      call Flatten(line.children, out)
    endfor
    return out
  endfun

  call setline(a:line1, Flatten(lines))
endfun

" highlight-less done items
augroup VimWikiToDo
    autocmd!
    autocmd FileType vimwiki syntax match VimWikiToDoDone '\v^((\*|\s{4}\*|\t\*)\s\[(\.|o|O|X)\]\s)'
    autocmd FileType vimwiki highlight link VimWikiToDoDone Comment
augroup END

" Set F5 to save and run the current python file
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Improve scroll performance
augroup syntaxSyncMinLines
    autocmd!
    autocmd Syntax * syntax sync minlines=500
augroup END

" Include user's custom vim configurations
let custom_configs_path = "~/.vim/custom.vim"
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif
