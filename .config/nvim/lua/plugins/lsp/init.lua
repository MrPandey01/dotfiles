return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-omni" },
      { "uga-rosa/cmp-dictionary" },
      { "quangnguyen30192/cmp-nvim-tags" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
    },
    event = "BufReadPre",
    config = function()
      local lsp_zero = require "lsp-zero"
      lsp_zero.preset "recommended"

      -- Disable default keybindings (optional)
      lsp_zero.set_preferences {
        set_lsp_keymaps = false,
      }

      lsp_zero.on_attach(function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", bufopts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufopts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", bufopts)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", bufopts)
        vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", bufopts)
        vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", bufopts)
        --[[ vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts) ]]
        --[[ vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts) ]]
        --[[ vim.keymap.set('n', '<space>bf', function() vim.lsp.buf.format { async = true } end, bufopts) ]]
        --[[ vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) ]]
        --[[ vim.keymap.set('n', '<M-k>', function() require('lsp_signature').toggle_float_win() end, bufopts) ]]
        --[[ vim.keymap.set('i', '<M-n>', function() require('lsp_signature').select_signature_key() end, bufopts) ]]
        --[[ vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', bufopts) ]]
        --[[ vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<cr>', bufopts) ]]
      end)

      lsp_zero.ensure_installed {
        "pyright",
        "marksman",
        "yamlls",
        "lua_ls",
        "bashls",
      }

      lsp_zero.configure("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "off",
            },
          },
        },
      })

      lsp_zero.configure("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
          },
        },
      })


      -- configure cmp
      require "plugins.lsp.cmp".setup()


      -- LuaSnip config
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
      require("luasnip").config.set_config({
        -- Setting LuaSnip config
        history = true,
        update_events = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })

      lsp_zero.setup()
    end,
  },


  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      -- null-ls is not a part of lsp-zero, hence called after lsp.setup()
      local null_ls = require "null-ls"
      local null_opts = require("lsp-zero").build_options("null-ls", {})

      null_ls.setup {
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
          --- you can add more stuff here if you need it
        end,
        -- formatters
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.latexindent,
          null_ls.builtins.formatting.prettier,
        },
      }
    end,
  },

  {
    'ray-x/lsp_signature.nvim',
    event = { "BufReadPost" },
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      },
      toggle_key = '<M-k>',           -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
      select_signature_key = '<M-n>', -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil,          -- imap, use nvim_set_current_win to move cursor between current win and floating
    },
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
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
      })
    end,
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
  }
}
