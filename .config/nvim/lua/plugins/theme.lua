return { 
  'Mofiqul/dracula.nvim',
  name = 'dracula',
  lazy = false,
  
  init = function()
    vim.cmd.colorscheme('dracula')
  end,
  
  config = function() require('dracula').setup({
    styles = {
      transparency = true,
    },
  }) end,
}
