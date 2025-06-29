return {
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
      cwd_change_handling = true,

      post_cwd_changed_cmds = {
        function()
          require('lualine').refresh() -- example refreshing the lualine status line _after_ the cwd changes
        end,
      },
    },
  },
}
