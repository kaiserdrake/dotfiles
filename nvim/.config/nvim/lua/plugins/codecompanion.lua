return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
          completion_provider = "blink", -- blink|cmp|coc|default
          keymaps = {
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
              index = 3,
              callback = function()
                require("codecompanion").toggle()
              end,
              description = "Toggle Chat",
            }
          }
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        }
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
      },
    },
  },
}
