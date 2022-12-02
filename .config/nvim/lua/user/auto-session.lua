require("auto-session").setup({
  auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
  log_level = 'error',
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_use_git_branch = true,
})
