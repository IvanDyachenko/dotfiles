return {
  -- It helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- It uses virtual text and gutter signs to show you motions that are available to you and where they would take you.
  {
    "tris203/precognition.nvim",
    opts = {},
  },

  -- A completion engine plugin.
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local conf = {
        sources = {
          { name = "vsnip" },
          { name = "nvim_lsp" },
        },
        snippet = {
          expand = function(args)
            -- Comes from vsnip.
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- None of this made sense to me when first looking into this since there
          -- is no vim docs, but you can't have select = true here _unless_ you are
          -- also using the snippet stuff. So keep in mind that if you remove
          -- snippets you need to remove this select
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      }
      return conf
    end,
  },
}
