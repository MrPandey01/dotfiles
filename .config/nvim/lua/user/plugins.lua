local fn = vim.fn
local utils = require("user.utils")

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
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use 'lewis6991/impatient.nvim'
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
        && cmake --build build --config Release \
        && cmake --install build --prefix build' }
  use "benfowler/telescope-luasnip.nvim"
  use "machakann/vim-sandwich"
  use "Pocco81/auto-save.nvim"
  use({ 'vladdoster/remember.nvim', config = [[ require('remember') ]] })
  use 'lervag/vimtex'
  use "lukas-reineke/indent-blankline.nvim"
  use 'goolord/alpha-nvim' -- home page
  use "folke/which-key.nvim"
  use 'ggandor/leap.nvim'
  use { 'ggandor/flit.nvim', requires = 'ggandor/leap.nvim' }
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  use 'karb94/neoscroll.nvim'
  use 'rmagatti/auto-session'
  use 'ahmedkhalf/project.nvim'
  use 'tpope/vim-repeat'

  -- Buffers
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = { 'kyazdani42/nvim-web-devicons' } }
  use "moll/vim-bbye"

  -- Comment
  use "numToStr/Comment.nvim"
  use 'JoosepAlviste/nvim-tComments-context-commentstring'
  
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
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', }, }

  -- Syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
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
      { 'uga-rosa/cmp-dictionary' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'quangnguyen30192/cmp-nvim-tags' },
      { 'rcarriga/cmp-dap' }, -- debugger completion

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },

      -- Snippets
      -- use { 'SirVer/ultisnips' }
      -- use { 'quangnguyen30192/cmp-nvim-ultisnips' }

    }
  }

  -- Only install these plugins if ctags are installed on the system
  if utils.executable("ctags") then
    -- show file tags in vim window
    use { "liuchengxu/vista.vim", cmd = "Vista" }
  end

  -- Colorschemes and highlighting
  use "kyazdani42/nvim-web-devicons"
  use 'navarasu/onedark.nvim'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { "Djancyp/custom-theme.nvim" }
  use { 'norcalli/nvim-colorizer.lua' }

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Debugging
  use { "mfussenegger/nvim-dap" }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { "mfussenegger/nvim-dap" } }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } }
  use { 'mfussenegger/nvim-dap-python', requires = { "mfussenegger/nvim-dap" } }
  use { 'jbyuki/one-small-step-for-vimkind' }

  -- temporary
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
