local M = {}


function M.setup()
  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
      {
        elements = {
          "repl",
          { id = "scopes", size = 0.25 },
          --[[ "breakpoints", ]]
          --[[ "stacks", ]]
          --[[ "watches", ]]
        },
        size = 60,     -- 40 columns
        position = "right",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "↻",
        terminate = "□",
      },
    },
    floating = {
      max_height = nil,      -- These can be integers or a float between 0 and 1.
      max_width = nil,       -- Floats will be treated as percentage of your screen.
      border = "single",     -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil,     -- Can be integer or nil.
      max_value_lines = 100,     -- Can be integer or nil.
    }
  })
end

return M
