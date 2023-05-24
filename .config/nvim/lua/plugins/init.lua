return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup {
        override = require("nvim-material-icon").get_icons(),
      }
    end,
  },
  { "tpope/vim-repeat",   event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy" },
      buftype_exclude = { "terminal", "nofile" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = false,
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    event = { "VeryLazy" },
    config = function(_, _)
      require("Comment").setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    "machakann/vim-sandwich",
    event = { "InsertEnter" },
    lazy = true,
  },
  {
    -- session management
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help" }
    },
  },
  { 'wellle/targets.vim', event = 'InsertEnter' }, -- extends textobjects
  {
    "p00f/nvim-ts-rainbow",
    event = { "BufReadPost" },
  },
  {
    "vladdoster/remember.nvim",
    lazy = false,
    config = function()
      require("remember").setup({
        open_folds = false,
      })
    end,
  },
}
