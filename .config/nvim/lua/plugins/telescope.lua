return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({ layout_strategy = "vertical" })
      end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>lg",
      function()
        require("telescope.builtin").live_grep({ layout_strategy = "vertical" })
      end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>ss",
      require("telescope.builtin").lsp_document_symbols,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        file_ignore_patterns = { "target", "out" },
        prompt_prefix = "❯",
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        mappings = {
          n = {
            ["f"] = actions.send_to_qflist,
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzy_native")
  end,
}
