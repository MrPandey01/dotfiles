-- null-ls is not a part of lsp-zero, hence called after lsp.setup()
local null_ls = require('null-ls')
local null_opts = require('lsp-zero').build_options('null-ls', {})

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

