function! myconfig#before() abort

  syntax on
  let g:mapleader = '\'
  let g:auto_save = 1  " enable AutoSave on Vim startup (autosave plugin)

  " Code folding
  set foldmethod=indent
  set nofoldenable
  set foldlevel=2

  set conceallevel=2
  set modifiable

  " Spell check and completion
  set complete+=kspell
  set spelllang=en_us,cjk 
  set spellsuggest=best,8
  set spellfile=~/.vim/spell/en.utf-8.add
  " setlocal spell  # Uncomment to turn-on by default
  
  set breakindent
  let &showbreak=' '
  
  " Change cursor shape in different modes
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"

  if (has('termguicolors'))
    " Color and cursor for tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  " Use the OS clipboard by default (on versions compiled with `+clipboard`)
  if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
  else
      set clipboard=unnamed
  endif


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
        \ 'sections': 1,
        \ 'styles': 1,
        \}

  let g:vimtex_quickfix_mode=0
  let g:vimtex_quickfix_open_on_warning=0
  
  " Disable custom warnings based on regexp
  let g:vimtex_quickfix_ignore_filters = [
        \ ' Marginpar on page ',
        \ ' Underfull ',
        \ ' Overfull ',
        \ ' hyperref ',
        \ ' typearea ',
        \ ' Delete this space ',
        \ ' Non-breaking space ',
        \ ' Interword spacing ',
        \ ' Use either ',
        \ ' Delete this space ',
        \ ' You should ',
        \]
  let g:vimtex_view_general_viewer='qpdfview'
  let g:vimtex_view_general_options='--unique @pdf\#src:@tex:@line:@col'
  let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 0,
      \ 'executable' : 'latexmk',
      \ 'hooks' : [],
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}
  " let g:vimtex_view_general_options_latexmk='--unique'
  let g:vimtex_lint_chktex_ignore_warnings='-n1 -n2 -n3 -n8 -n25 -n24 -n2'
  let g:neomake_enabled_tex_makers = []

  " let g:semshi#filetypes=['python', 'tex'] " Extra syntax highlighting for python

  " COC settings ---------------------------------
  let g:coc_config_home = '~/.SpaceVim.d/'
  let g:coc_global_extensions = [
        \ 'coc-dictionary',
        \ 'coc-word',
        \'coc-pyright',
        \ ]

  " NerdTree ---------------------------------
  let g:NERDTreeRespectWildIgnore=1
  
  " Material theme extra configuration---------------------------------
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'darker'
  let g:airline_theme = 'material'


  let g:python_highlight_all = 1

  " packadd! ~/.cache/vimfiles/repos/github.com/puremourning/vimspector

  let g:vimspector_base_dir='~/.cache/vimfiles/repos/github.com/puremourning/vimspector'

  " UltiSnippets ---------------------------
  " Snippets Trigger configuration.
  " Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
  " let g:UltiSnipsExpandTrigger="<tab>"
  " let g:UltiSnipsJumpForwardTrigger="<tab>"
  " let g:UltiSnipsJumpBackwardTrigger="<shift+tab>"
  let g:UltiSnipsEditSplit="vertical""
  let g:UltiSnipsSnippetDirectories=["UltiSnips"]


  let g:pydocstring_doq_path = '~/.conda/envs/py_env/bin/doq'

  let g:webdevicons_enable_startify = 1

  " Disable welcome screen
  " let g:spacevim_disabled_plugins = ['vim-startify']

  " let g:coc_snippet_next = '<tab>'

endfunction


function! myconfig#after() abort

  set wrap  " wrap text around the screen

   " Neovim Synctex setup (requires pip install neovim-remote)
  function! s:write_server_name() abort
    let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
    call writefile([v:servername], nvim_server_file)
  endfunction

  augroup vimtex_common
    autocmd!
    autocmd FileType tex call s:write_server_name()
  augroup END

  if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
  endif

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


  " Comment toggle with Ctrl-/
  nnoremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>
  vnoremap <silent> <C-_> :call NERDComment(0,"toggle")<CR>

  " Set F5 to save and run the current python file
  autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>



  " CoC settings --------------------------------------------------------------------
  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Key Configurations ---------------------------------

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
  imap hh <Esc>
  imap jj <Esc>
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
