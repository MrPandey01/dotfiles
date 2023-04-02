local M = {}

function M.setup()
  local snippets_folder = vim.fn.stdpath "config" .. "/lua/snippets/"

  require("luasnip.loaders.from_lua").load({ paths = snippets_folder })

  require("luasnip").config.set_config({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
  })

  vim.api.nvim_create_user_command("LuaSnipEdit", function()
    require("luasnip.loaders.from_lua").edit_snippet_files()
  end, {})

end

return M
