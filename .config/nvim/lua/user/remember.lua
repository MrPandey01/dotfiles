local status_ok, remember = pcall(require, "remember")
	return
end

remember.setup({
	ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	ignore_buftype = { "quickfix", "nofile", "help" },
	open_folds = true,
})


