local M = {}

function M.setup()
  local cmp = require "cmp"
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup {
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    preselect = 'item',
    completion = {
      completeopt = "menu,menuone,preview,noinsert",
    },
    mapping = {
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      ["<C-k>"] = cmp.mapping.scroll_docs(-4),
      ["<C-j>"] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
    sources = {
      { name = "omni" },
      { name = "copilot" },
      { name = "luasnip",    option = { show_autosnippets = true } },
      { name = "path" },
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "dictionary", keyword_length = 4 },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = require('lspkind').cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,         -- prevent the popup from showing more than provided characters
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        menu = ({
          omni = "[Omni]",
          copilot = "[Copilot]",
          luasnip = "[LuaSnip]",
          path = "[Path]",
          buffer = "[Buffer]",
          nvim_lsp = "[nvim_lsp]",
          nvim_lua = "[nvim_lua]",
          dictionary = "[Dict]",
        })
      })
    },
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
  }

  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
  end)

  require("cmp_dictionary").setup {
    dic = {
      ["*"] = { "~/.config/nvim/spell/en.dict" },
    },
  }

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local handlers = require('nvim-autopairs.completion.handlers')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
      filetypes = {
        -- "*" is a alias to all filetypes
        ["*"] = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers["*"]
          }
        },
        lua = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method
            },
          }
        },
        -- Disable for tex
        tex = false
      }
    })
  )
end

return M
