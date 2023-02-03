local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
	vim.notify(auto_session, vim.log.levels.ERROR)
  return
end

auto_session.setup({
  auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
  log_level = 'error',
  auto_session_enabled = true,
})
