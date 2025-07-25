return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))
      return {
        suggestion = {
          enabled = not vim.g.ai_cmp,
          auto_trigger = true,
          hide_during_completion = vim.g.ai_cmp,
          keymap = {
            -- accept = false, -- handled by nvim-cmp / blink.cmp
            accept = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          gitcommit = true,
          ['*'] = function()
            -- disable for files with specific names
            local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
            local disable_patterns = { 'env', 'conf', 'secret', 'private', 'license' }
            return vim.iter(disable_patterns):all(function(pattern)
              return not string.match(fname, pattern)
            end)
          end,
        },
      }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = "CopilotChat",
    dependencies = {
      -- { "zbirenbaum/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",

    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "claude-sonnet-4",
        agent = "copilot",
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
        prompts = {
          Align = {
            prompt = 'Align the components of the selected code by adding whitespaces following recommended suggestion based on filetype.',
            description = 'Align the selected code block by adding whitespaces',
          },
          Commit = {
            prompt = 'Write a commit message for the change with commitizen convention.' ..
              'Keep the title under 50 characters and wrap message at 72 characters.' ..
              'Remove the changelog category `<tag>:` from the beginning of the title line.' ..
              'List the changes in the body of the commit message. use `-` as list indicator.' ..
              'Format as a gitcommit code block.' ..
              'Add a commit git trailer with `Changelog: bugfix; feature; docs; chore; refactor; style; test` as needed.',
            description = 'Write a commit entry for the staged changes.',
            context = 'git:staged',
          },
          Docs = {
            prompt = 'Please add documentation to the selected code.' ..
              'Use the format of a code block with the language of the file.' ..
              'Do not add documentation to self-evident code, especially where name of enumerations or variables are self-explanatory.',
            description = 'Add documentation to the selected code.',
          },
          MisraC = {
            prompt = 'Check the code in #buffer:current for compliance with MISRA C:2012 rules.' ..
              'If there are no violations, return "No violations found."' ..
              'If there are any violations, list them in a code block with the language of the file group by rules.' ..
              'Provide a brief explanation of each violation and how to fix it.' ..
              'Use the format of a code block with the language of the file.' ..
              'Exclude any rules that are included in the #file:.misra_c_exceptions.json.',
            description = 'Check the selected code for compliance with MISRA C:2012 rules.',
            context = 'buffer:current',
          },
          Tests = {
            prompt = 'Write a test for the selected code.' ..
              'Use the format of a code block with the language of the file.' ..
              'If the code is self-evident, do not write a test.' ..
              'When application, use cmocka for C code, and pytest for Python code.' ..
              'If the code is a function, write a test for the function.',
            description = 'Write a test for the selected code.',
          },
        },
        mappings = {
          reset = {
            normal = '<C-b>',
            insert = '<C-b>',
          },
          show_diff = {
            full_diff = true
          },
        }
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
              if input ~= "" then
                require("CopilotChat").ask(input)
              end
            end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  }
}
