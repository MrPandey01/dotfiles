function! myconfig#before() abort

  syntax on
  let g:mapleader = '\'
  let g:auto_save = 1  " enable AutoSave on Vim startup (autosave plugin)

  " Code folding
  set foldmethod=indent
  set nofoldenable
  set foldlevel=2

  set scrolloff=999  " keep the cursor mostly in the middle of the screen

  " When searching, ignore case unless you type a capital, in which case it’ll match case (smartcase).
  set ignorecase smartcase

  set conceallevel=2
  " set modifiable

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
  let g:neomake_open_list = 0  " Don't open neomake list automatically

  " COC settings ---------------------------------
  let g:coc_config_home = '~/.SpaceVim.d/'
  let g:coc_global_extensions = [
        \'coc-word',
        \'coc-pyright',
        \'coc-ultisnips',
        \'coc-texlab',
        \'coc-sql',
        \'coc-html',
        \ ]

  " NerdTree ---------------------------------
  let g:NERDTreeRespectWildIgnore=1
  
  " Material theme extra configuration---------------------------------
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'darker'
  let g:airline_theme = 'material'

  let g:python_highlight_all = 1

  " UltiSnippets ---------------------------
  " Snippets Trigger configuration.
  " Do not use <tab> if you use " https://github.com/Valloric/YouCompleteMe.
  " let g:UltiSnipsExpandTrigger="<Tab>"
  " let g:UltiSnipsJumpForwardTrigger="<tab>"
  " let g:UltiSnipsJumpBackwardTrigger="<shift+tab>"
  let g:UltiSnipsEditSplit="vertical""
  let g:UltiSnipsSnippetDirectories=["UltiSnips"]


  let g:pydocstring_doq_path = '~/.conda/envs/py_env/bin/doq'

  let g:webdevicons_enable_startify = 1

  " Disable welcome screen
  " let g:spacevim_disabled_plugins = ['vim-startify']

  " vim-slime ---------------------------
  let g:slime_paste_file = '~/.slime_paste'
  let g:slime_target = "tmux"
  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

endfunction


function! myconfig#after() abort

  set wrap  " wrap text around the screen

  " trigger `autoread` when files changes on disk
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

  " notification after file change
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


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
  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  " nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Telescope Settings ---------------------------------
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fc <cmd>Telescope commands<cr>

  " Key Configurations ---------------------------------
  " Easy writing and quitting
  nnoremap <leader>w :w<cr>
  nnoremap <leader>q :q!<cr>
  nnoremap <leader>z :wq<cr>

  " Move to beginning and end of line from home row
  " in both normal and visual mode
  nnoremap H ^
  nnoremap L $
  vnoremap H ^
  vnoremap L $

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
  nnoremap dw daw
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

  " For pasting (temporary, need to test for sometime)
  " Original `p` command still works but with a time-delay
  nnoremap paw "_dawP
  nnoremap pi{ "_di{P
  nnoremap pi} "_di}P
  nnoremap pi( "_di(P
  nnoremap pi) "_di)P
  nnoremap pi' "_di'P
  nnoremap pi" "_di"P

endfunction

