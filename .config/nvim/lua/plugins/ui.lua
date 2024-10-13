return {
  -- Color scheme.
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1024,
    init = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- Icon provider.
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
