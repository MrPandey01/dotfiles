-- install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require('lazy').setup({
  {
    "windwp/nvim-autopairs",
    config = function()
      require("user.plugins.autopairs")
    end
  },                       -- Autopairs, integrates with both cmp and treesitter
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
        && cmake --build build --config Release \
        && cmake --install build --prefix build'
  },
  { "kkharji/sqlite.lua" },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    dependencies = { "kkharji/sqlite.lua" }
  },
  {
    "benfowler/telescope-luasnip.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
  "machakann/vim-sandwich",
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function()
      require("user.plugins.vimtex")
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("user.plugins.indentline")
    end
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("user.plugins.alpha") 
    end
  },                                -- home page
  {
    "folke/which-key.nvim",
    config = function()
      require("user.plugins.whichkey") -- keymaps
    end
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    "ggandor/flit.nvim",
    dependencies = "ggandor/leap.nvim",
    config = function()
      require('flit').setup()
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require("user.plugins.ufo") -- folds
    end
  },                              -- code folding
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup() -- smooth scrolling
    end
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("user.plugins.autosave")
    end,
  },
  {
    "vladdoster/remember.nvim",
    config = function()
      require("user.plugins.remember")
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("user.plugins.auto-session")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
      require('telescope').load_extension('projects')
    end,
  },
  "tpope/vim-repeat", -- enables . operator to leap and other plugins
  -- Buffers
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("user.plugins.bufferline")
    end
  },
  "moll/vim-bbye",
  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("user.plugins.comment")
    end
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  -- Docstrings and annotations
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    version = "*"
  },
  -- File explorer
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons', },
    config = function()
      require("user.plugins.nvim-tree")
    end
  },
  -- Syntax highlighting and textobjects
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("user.plugins.treesitter")
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  {
    'nvim-treesitter/playground',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  { 'wellle/targets.vim' }, -- extends textobjects
  "p00f/nvim-ts-rainbow",
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-omni' },
      { 'uga-rosa/cmp-dictionary' },
      --[[ { 'hrsh7th/cmp-nvim-lsp-signature-help' }, ]]
      { 'quangnguyen30192/cmp-nvim-tags' },
      { 'rcarriga/cmp-dap' }, -- debugger completion

      -- Snippets
      { 'L3MON4D3/LuaSnip' },

    },
    config = function()
      require("user.plugins.lsp")
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        },
        toggle_key = '<M-k>',           -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        select_signature_key = '<M-n>', -- cycle to next signature, e.g. '<M-n>' function overloading
        move_cursor_key = nil,          -- imap, use nvim_set_current_win to move cursor between current win and floating
      })
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
      })
    end,
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
  },



  -- Colorschemes and highlighting
  "kyazdani42/nvim-web-devicons",
  {
    'navarasu/onedark.nvim',
    config = function()
      require("user.plugins.onedark")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("user.plugins.lualine")
    end
  },
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("hlargs").setup()
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.plugins.gitsigns")
    end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("user.plugins.dap") -- debugger
    end
  },
  { 'theHamsta/nvim-dap-virtual-text',   dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/nvim-dap-ui",              dependencies = { "mfussenegger/nvim-dap" } },
  { "nvim-telescope/telescope-dap.nvim", dependencies = { "mfussenegger/nvim-dap" } },
  { 'mfussenegger/nvim-dap-python',      dependencies = { "mfussenegger/nvim-dap" } },
  { 'jbyuki/one-small-step-for-vimkind', dependencies = { "mfussenegger/nvim-dap" } },
})
