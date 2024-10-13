local metals = {
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

local lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("nvim-lsp", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set(
            "n",
            keys,
            func,
            { buffer = event.buf, desc = "LSP: " .. desc }
          )
        end

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

        map(
          "gr",
          require("telescope.builtin").lsp_references,
          "[G]oto [R]eferences"
        )

        map(
          "gI",
          require("telescope.builtin").lsp_implementations,
          "[G]oto [I]mplementation"
        )

        map(
          "<leader>D",
          require("telescope.builtin").lsp_type_definitions,
          "Type [D]efinition"
        )

        map(
          "<leader>ds",
          require("telescope.builtin").lsp_document_symbols,
          "[D]ocument [S]ymbols"
        )

        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
      },
      completion = {
        autocomplete = false,
      },
    })

    -- LSP servers and clients can exchange information about the features they support.
    -- By default, Neovim does not support all the functionalities outlined in the LSP specification.
    -- When enhancements like nvim-cmp and etc. are added, Neovim's capabilities are broadened.
    -- Thus, we create new capabilities with `nvim-cmp`, then broadcast this information to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )
  end,
}

return {
  metals,
  lspconfig,
}
