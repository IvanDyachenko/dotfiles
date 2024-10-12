return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      treesitter = {
        enable = false,
      },
      playground = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      ensure_installed = "all",
    })
  end,
}
