return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  lazy = vim.fn.argc(-1) == 0, -- Load treesitter early when opening a file from the cmdline.
  dependencies = {
    -- Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  build = ":TSUpdate",
  opts = {
    auto_install = true,
    -- Indentation based on treesitter for the `=` operator.
    indent = {
      enable = true,
    },
    -- Consistent syntax highlighting.
    highlight = {
      enable = true,
    },
    textobjects = {
      enable = true,
      move = {
        enable = true,
      },
    },
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "java",
      "json",
      "kotlin",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "nix",
      "proto",
      "regex",
      "rust",
      "scala",
      "sql",
      "toml",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
}
