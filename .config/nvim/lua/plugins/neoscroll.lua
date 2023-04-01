return {
  {
    "karb94/neoscroll.nvim",
    keys = {
      { '<C-u>' },
      { '<C-d>' },
      { '<C-b>' },
      { '<C-f>' },
    },
    config = function()
      require('neoscroll').setup() -- smooth scrolling
    end
  }
}
