local M = {}

function M.setup()
  -- LuaSnip config
  require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
  require("luasnip").config.set_config({
    -- Setting LuaSnip config
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
  })
end

return M
