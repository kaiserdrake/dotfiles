return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          signature = {
            enabled = false, -- prevent conflict with lsp_signature
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        views = {
          -- Clean cmdline_popup + palette
          cmdline_popup = {
            position = {
              row = 32,
              col = "50%",
            },
            border = {
              style = "rounded",
            },
            size = {
              min_width = 60,
              width = "auto",
              height = "auto",
            },
            win_options = {
              winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
            },
          },
          cmdline_popupmenu = {
            relative = "editor",
            position = {
              row = 35,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
              max_height = 15,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "NoiceCmdlinePopupBorder" },
            },
          },
          hover = {
            border = {
              style = "single",
            },
          },
          confirm = {
            border = {
              style = "single",
            },
          },
          popup = {
            border = {
              style = "single",
            },
          },
        },
        })
    end,
  },

}
