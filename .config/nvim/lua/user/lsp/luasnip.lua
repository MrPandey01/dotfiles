-- load custom snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

-- LuaSnip config
require("luasnip").config.set_config({ -- Setting LuaSnip config
  history = true,
  update_events = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})
