return {
  "Mofiqul/dracula.nvim",
  name = "dracula",
  lazy = false,
  priority = 1024,
  init = function()
    vim.cmd.colorscheme("dracula")
  end,
}
