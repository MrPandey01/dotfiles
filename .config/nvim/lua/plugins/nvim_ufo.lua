return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    keys = {
      { "zc" },
      { "zo" },
      { "zC" },
      { "zO" },
      { "za" },
      { "zA" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds", },
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds", },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds", },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With", },
      { "zp", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek Fold", },
    },
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end
      })
    end
  }
}
