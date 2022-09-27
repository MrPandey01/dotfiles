vim.cmd([[
  " vim-slime ---------------------------
  let g:slime_paste_file = '~/.slime_paste'
  let g:slime_target = "tmux"
  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
]])
