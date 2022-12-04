-- LuaSnip config
require("luasnip").config.set_config({ -- Setting LuaSnip config
  snip_env = {
    s = require("luasnip.nodes.snippet").S,
    sn = require("luasnip.nodes.snippet").SN,
    isn = require("luasnip.nodes.snippet").ISN,
    t = require("luasnip.nodes.textNode").T,
    i = require("luasnip.nodes.insertNode").I,
    f = require("luasnip.nodes.functionNode").F,
    c = require("luasnip.nodes.choiceNode").C,
    d = require("luasnip.nodes.dynamicNode").D,
    r = require("luasnip.nodes.restoreNode").R,
    events = require("luasnip.util.events"),
    ai = require("luasnip.nodes.absolute_indexer"),
    extras = require("luasnip.extras"),
    l = require("luasnip.extras").lambda,
    rep = require("luasnip.extras").rep,
    p = require("luasnip.extras").partial,
    m = require("luasnip.extras").match,
    n = require("luasnip.extras").nonempty,
    dl = require("luasnip.extras").dynamic_lambda,
    fmt = require("luasnip.extras.fmt").fmt,
    fmta = require("luasnip.extras.fmt").fmta,
    conds = require("luasnip.extras.expand_conditions"),
    postfix = require("luasnip.extras.postfix").postfix,
    types = require("luasnip.util.types"),
    parse = require("luasnip.util.parser").parse_snippet,
  },

  update_events = 'TextChanged,TextChangedI',

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})
-- load custom snippets
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
