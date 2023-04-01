return {
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers", -- tabs or buffers
        diagnostics = "nvim_lsp",
      },
    },
  },
}
