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
      desc = "[F]ind [F]iles (Root Dir)",
    },
    {
      "<leader>lg",
      function()
        require("telescope.builtin").live_grep({ layout_strategy = "vertical" })
      end,
      desc = "[L]ive [G]rep (Root Dir)",
    },
  },
  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        file_ignore_patterns = { "target", "out" },
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
