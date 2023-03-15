local fn = vim.fn

-- Install packer
local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    cmd = 'git',    -- The base command for git operations
    subcommands = {
                    -- Format strings for git subcommands
      update         = 'pull --ff-only --progress --rebase=true',
      install        = 'clone --depth %i --no-single-branch --progress',
      fetch          = 'fetch --depth 999999 --progress',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs",
    config = function()
      require("user.plugins.autopairs")
    end } -- Autopairs, integrates with both cmp and treesitter

  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
        && cmake --build build --config Release \
        && cmake --install build --prefix build' }
  use { "kkharji/sqlite.lua" }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    requires = { "kkharji/sqlite.lua" }
  }
  use { "benfowler/telescope-luasnip.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
    end, }

  use "machakann/vim-sandwich"
  use { "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function()
      require("user.plugins.vimtex")
    end
  }
  use { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("user.plugins.indentline")
    end }
  use { "goolord/alpha-nvim",
    config = function()
      require("user.plugins.alpha") -- home screen
    end }                           -- home page
  use { "folke/which-key.nvim",
    config = function()
      require("user.plugins.whichkey") -- keymaps
    end }
  use { "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end }
  use { "ggandor/flit.nvim", requires = "ggandor/leap.nvim",
    config = function()
      require('flit').setup()
    end }
  use { "kevinhwang91/nvim-ufo",
    requires = 'kevinhwang91/promise-async',
    config = function()
      require("user.plugins.ufo") -- folds
    end }                         -- code folding
  use { "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup() -- smooth scrolling
    end }
  use { "Pocco81/auto-save.nvim",
    config = function()
      require("user.plugins.autosave")
    end, }
  use { "vladdoster/remember.nvim",
    config = function()
      require("user.plugins.remember")
    end, }
  use { "rmagatti/auto-session",
    config = function()
      require("user.plugins.auto-session")
    end, }
  use { "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
      require('telescope').load_extension('projects')
    end, }
  use "tpope/vim-repeat" -- enables . operator to leap and other plugins

  -- Buffers
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("user.plugins.bufferline")
    end }
  use "moll/vim-bbye"

  -- Comment
  use { "numToStr/Comment.nvim",
    config = function()
      require("user.plugins.comment")
    end
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Docstrings and annotations
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    tag = "*"
  }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', },
    config = function()
      require("user.plugins.nvim-tree")
    end }


  -- Syntax highlighting and textobjects
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require("user.plugins.treesitter")
    end }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 'nvim-treesitter/playground' }

  use { 'wellle/targets.vim' } -- extends textobjects
  use "p00f/nvim-ts-rainbow"

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
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
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'quangnguyen30192/cmp-nvim-tags' },
      { 'rcarriga/cmp-dap' }, -- debugger completion

      -- Snippets
      { 'L3MON4D3/LuaSnip' },

    },
    config = function()
      require("user.plugins.lsp")
    end
  }
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
      })
    end
  }

  -- Colorschemes and highlighting
  use "kyazdani42/nvim-web-devicons"
  use { 'navarasu/onedark.nvim',
    config = function()
      require("user.plugins.onedark")
    end }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("user.plugins.lualine")
    end }
  use { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("hlargs").setup()
    end }

  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end }


  -- Git
  use { "lewis6991/gitsigns.nvim",
    config = function()
      require("user.plugins.gitsigns")
    end, }

  -- Debugging
  use { "mfussenegger/nvim-dap",
    config = function()
      require("user.plugins.dap") -- debugger
    end }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { "mfussenegger/nvim-dap" } }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } }
  use { 'mfussenegger/nvim-dap-python', requires = { "mfussenegger/nvim-dap" } }
  use { 'jbyuki/one-small-step-for-vimkind', requires = { "mfussenegger/nvim-dap" } }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
