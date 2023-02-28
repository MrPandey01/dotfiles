-- disable netrw at the very start of your init.lua (strongly advised)
-- following 2 lines are added in user.options
--[[ vim.g.loaded_netrw = 1 ]]
--[[ vim.g.loaded_netrwPlugin = 1 ]]

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify(nvim_tree, vim.log.levels.ERROR)
  return
end

--[[ local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config") ]]
--[[ if not config_status_ok then ]]
--[[ 	vim.notify(nvim_tree_config, vim.log.levels.ERROR) ]]
--[[   return ]]
--[[ end ]]

--[[ local tree_cb = nvim_tree_config.nvim_tree_callback ]]


nvim_tree.setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  disable_netrw = true,
  hijack_netrw = true,
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 25,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, action = "edit" },
        { key = "h", action = "close_node" },
        { key = "s", action = "vsplit" },
        { key = "t", action = "tabnew" },
      },
    },
    number = false,
    relativenumber = false,
  },
})
