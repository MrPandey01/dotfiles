local status_ok, remember = pcall(require, "remember")
if not status_ok then
	vim.notify(remember, vim.log.levels.ERROR)
  return
end

remember.setup({
	open_folds = false,
})


