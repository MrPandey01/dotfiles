local M = {}

function M.setup()
  local lspconfig = require 'lspconfig'

  lspconfig.pyright.setup({
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

  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  local words = {}
  for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
    table.insert(words, word)
  end

  lspconfig.ltex.setup({
    settings = {
      ltex = {
        dictionary = {
          ["en-US"] = words,
        },
        latex = {
          commands = {
            ["\\jurymember{}"] = "ignore",
            ["\\president{}"] = "ignore",
            ["\\externaljurymember{}{}"] = "ignore",
            ["\\tikzstyle{} = []"] = "ignore",
            ["\\tabfigure{}{}"] = "ignore",
            ["\\includechapter{}"] = "ignore",
            ["\\includeappendix{}"] = "ignore",
            ["\\printpublication{}"] = "ignore",
          },
          environments = {
            ["empheq"] = "ignore",
          },
        },
      },
    },
  })
end

return M
