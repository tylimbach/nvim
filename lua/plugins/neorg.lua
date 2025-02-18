return {
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
            index = "index.norg",
          },
        },
        ["core.journal"] = {
          config = {
            journal_folder = "journal",
            workspace = "notes",
            strategy = "flat",
          },
        },
        -- ["core.completion"] = {
        --   config = {
        --     engine = "nvim-cmp",
        --   },
        -- },
      },
    },
    config = true,
  },
}
