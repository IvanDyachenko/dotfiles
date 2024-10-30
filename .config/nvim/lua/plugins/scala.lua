return {
  "scalameta/nvim-metals",
  dependencies = {
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    {
      "mfussenegger/nvim-dap",
      config = function(self, opts)
        local dap = require("dap")
        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }
      end,
    },
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    metals_config.settings = { showImplicitArguments = true }
    metals_config.init_options.statusBarProvider = "off"
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, buf)
      require("metals").setup_dap()

      local map = function(keys, func, desc)
        vim.keymap.set(
          "n",
          keys,
          func,
          { buffer = buf, desc = "LSP: " .. desc }
        )
      end

      map("<leader>dc", function()
        require("dap").continue()
      end, "")

      map("<leader>dr", function()
        require("dap").repl.toggle()
      end, "")

      map("<leader>dK", function()
        require("dap.ui.widgets").hover()
      end, "")

      map("<leader>dt", function()
        require("dap").toggle_breakpoint()
      end, "")

      map("<leader>dso", function()
        require("dap").step_over()
      end, "")

      map("<leader>dsi", function()
        require("dap").step_into()
      end, "")

      map("<leader>dl", function()
        require("dap").run_last()
      end, "")
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group =
      vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
