return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle" },
  lazy = true,
  keys = {
    { "<F3>", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  },
  opts = {
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
    filters = {
      custom = { ".git" },
    },
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
      update_cwd = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
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
      number = false,
      relativenumber = false,
    },
  },
}
