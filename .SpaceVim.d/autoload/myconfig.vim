function! myconfig#before() abort


  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  syntax on

  " Material theme extra configuration
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'darker'
  let g:airline_theme = 'material'

  " Vimtex ---------------------------------
  let g:vimtex_syntax_conceal = {
        \ 'accents': 1,
        \ 'cites': 1,
        \ 'fancy': 1,
        \ 'greek': 1,
        \ 'math_bounds': 1,
        \ 'math_delimiters': 1,
        \ 'math_fracs': 1,
        \ 'math_super_sub': 1,
        \ 'math_symbols': 1,
        \ 'sections': 0,
        \ 'styles': 1,
        \}

  let g:vimtex_quickfix_mode=0
  let g:vimtex_quickfix_open_on_warning=0
  let g:vimtex_view_general_viewer='qpdfview'
  let g:vimtex_view_general_options='--unique @pdf\#src:@tex:@line:@col'
  let g:vimtex_view_general_options_latexmk='--unique'

  let g:mapleader = '\'

  let g:auto_save = 1  " enable AutoSave on Vim startup

  let g:semshi#filetypes=['python', 'tex']

  set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.tmp,*.synctex.gz,*.aux,*.log,*.out,*.blg,*.fls,*.fdb_latexmk,*.vrb,*.snm,*.nav,*.xml,*.toc,*.bcf,*.xdv,*.clo,*.bst,*.synctex(busy),*.bbl

  let NERDTreeRespectWildIgnore=1

  " Code folding
  set foldmethod=indent
  set nofoldenable
  set foldlevel=2
  set conceallevel=2

  set breakindent
  let &showbreak=' '

endfunction


function! myconfig#after() abort

  " Use the OS clipboard by default (on versions compiled with `+clipboard`)
  if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
  else
      set clipboard=unnamed
  endif

  set modifiable
  set wrap



   " Neovim Synctex setup (requires pip install neovim-remote)
function! s:write_server_name() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
  call writefile([v:servername], nvim_server_file)
endfunction

augroup vimtex_common
  autocmd!
  autocmd FileType tex call s:write_server_name()
augroup END

  " Inkscape-figures 
  inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
  nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
  "

  " Change cursor shape in different modes
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"

  " Optional reset cursor on start:
  augroup myCmds
      au!
      autocmd VimEnter * silent !echo -ne "\e[2 q"
  augroup END

  " Reopen the file at same cursor location
  if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                  \| exe "normal! g`\"" | endif
  endif

  " Clear search results with //
  nnoremap <silent> // :noh<CR>


  if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
  endif

  " Remap compile and view keys
  augroup vimrc_tex
      au!
      au FileType tex nmap <buffer><silent> <F5> <plug>(vimtex-compile)
      au FileType tex nmap <buffer><silent> <localleader>v <plug>(vimtex-view)
  augroup END

  " Comment toggle with Ctrl-/
    nnoremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>
    vnoremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>

  " Set F5 to save and run the current python file
  autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

  let g:python_highlight_all = 1

  " UltiSnippets ---------------------------
  " Snippets Trigger configuration.
  " Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<shift+tab>"
  let g:UltiSnipsEditSplit="vertical""
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "priv_snippets"]


  let g:pydocstring_doq_path = '~/.conda/envs/py_env/bin/doq'

  let g:webdevicons_enable_startify = 1

  " Disable welcome screen
  " let g:spacevim_disabled_plugins = ['vim-startify']

  " Key configurations ---------------------------------
  
  " TABS -------------------
  " Switch to last-active tab (read as: Tab-Toggle)
  if !exists('g:lasttab')
    let g:lasttab = 1
  endif
  nmap <Tab>t :exe "tabn ".g:lasttab<CR>
  au TabLeave * let g:lasttab = tabpagenr()

  " New tab
  " nnoremap <C-t> :tabnew<CR>

  " Disable arrow keys
  " noremap  <Up> ""
  " noremap! <Up> <Esc>
  " noremap  <Down> ""
  " noremap! <Down> <Esc>
  " noremap  <Left> ""
  " noremap! <Left> <Esc>
  " noremap  <Right> ""
  " noremap! <Right> <Esc>


  " For escaping
  imap jj <Esc>
  imap hh <Esc>
  imap kk <Esc>

  " For navigation (treat line breaks as new lines)
  vmap j gj
  nmap j gj
  vmap k gk
  nmap k gk

  " For Changing
  nnoremap cw ciw
  nnoremap c( ci(
  nnoremap c{ ci{
  nnoremap c[ ci[
  nnoremap c' ci'
  nnoremap c" ci"


  " For Yanking
  nnoremap yw yiw
  nnoremap y( yi(
  nnoremap y{ yi{
  nnoremap y[ yi[
  nnoremap y' yi'
  nnoremap y" yi"


  " For Deleting
  nnoremap dw diw
  nnoremap d( da(
  nnoremap d{ da{
  nnoremap d[ da[
  nnoremap d' da'
  nnoremap d" da"


  " For Selecting
  nnoremap vw viw
  nnoremap v( vi(
  nnoremap v{ vi{
  nnoremap v[ vi[
  nnoremap v' vi'
  nnoremap v" vi"

endfunction
