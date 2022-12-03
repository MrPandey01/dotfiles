local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    "sumneko_lua",
    "pyright",
    "texlab",
    "sumneko_lua",
    "marksman",
    "sqlls",
    "yamlls",
})

-- Disable default keybindings (optional)
lsp.set_preferences({
  set_lsp_keymaps = false
})

lsp.on_attach(function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', bufopts)
  --[[ vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) ]]
  vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', bufopts)
  vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', bufopts)
  vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', bufopts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', bufopts)
  vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
  vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
  --[[ vim.keymap.set('n', '<space>bf', function() vim.lsp.buf.format { async = true } end, bufopts) ]]

  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', bufopts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', bufopts)
  vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<cr>', bufopts)
end)

-- nvim-cmp setup
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

lsp.setup_nvim_cmp({
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'dictionary' },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        path = "[Path]",
        nvim_lsp = "[nvim_lsp]",
        buffer = "[Buffer]",
        luasnip = "[LuaSnip]",
        nvim_lsp_signature_help = "[nvim_lsp_signature]",
        dictionary = "[Dict]",
      })[entry.source.name]
      return vim_item
    end,
  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

local cmp = require("cmp")
require("cmp_dictionary").setup({
  dic = {
    ["*"] = { "~/.local/bin/en.dict" },
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

lsp.configure('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
      }
    }
  }
})

lsp.setup()



-- null-ls is not a part of lsp-zero, hence called after lsp.setup()
local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
    --- you can add more stuff here if you need it
  end,
  -- formatters
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.latexindent,
    null_ls.builtins.diagnostics.proselint,
  }
})
