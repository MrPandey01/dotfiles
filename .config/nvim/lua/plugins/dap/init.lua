return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>" },
      { "<leader>d" },
    },
    lazy = true,
    dependencies = {
      { "rcarriga/cmp-dap"  }, -- debugger completion
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "jbyuki/one-small-step-for-vimkind" },
      { 'mfussenegger/nvim-dap-python',     dependencies = { "mfussenegger/nvim-dap" } },
    },
    config = function()

      require("telescope").load_extension "dap"

      require("plugins.dap.nvim_dap_virtual_text").setup()
      require("plugins.dap.dapui").setup()

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Python setup
      require("dap-python").setup('python3')

      -- remove default configurations
      local t = dap.configurations.python
      for k in pairs(t) do
        t[k] = nil
      end
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Custom launch configuration',
        program = '${file}',
        -- ... more options, see
        -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      })


      -- Lua setup
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
      end
    end,
  },
}
