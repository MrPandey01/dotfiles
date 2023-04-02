return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "stevearc/aerial.nvim",
    },
    lazy = true,
    cmd = "Telescope",
    keys = {
      {
        "gr",
        function() require('telescope.builtin').lsp_references() end,
        desc = "lsp_references with telescope"
      },
      { "<leader>f" },
      { "<F2>" },
    },
    config = function(_, _)
      local telescope = require "telescope"
      telescope.load_extension "fzf"
      telescope.load_extension "projects"
      telescope.load_extension "frecency"
      telescope.load_extension "luasnip"
      telescope.load_extension "aerial"
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = true,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
        ignore_lsp = { "null-ls" },
      }
    end,
  },
}
