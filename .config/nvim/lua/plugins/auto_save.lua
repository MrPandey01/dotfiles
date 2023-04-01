return {
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave" },
    opts = {
      trigger_events = { "InsertLeave" }, -- vim events that trigger auto-save. See :h events
    },
  }
}
