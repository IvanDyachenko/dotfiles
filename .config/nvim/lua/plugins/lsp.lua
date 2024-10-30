return {
  "neovim/nvim-lspconfig",
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

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("gD", vim.lsp.buf.definition, "[G]oto [D]efinition")

        map(
          "<leader>gtD",
          require("telescope.builtin").lsp_type_definitions,
          "[G]oto [T]ype [D]efinition"
        )

        map(
          "gr",
          require("telescope.builtin").lsp_references,
          "[G]oto [R]eferences"
        )

        map(
          "gi",
          require("telescope.builtin").lsp_implementations,
          "[G]oto [I]mplementation"
        )

        map(
          "<leader>gds",
          require("telescope.builtin").lsp_document_symbols,
          "[G]oto [D]ocument [S]ymbols"
        )

        map(
          "<leader>gws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[G]oto [W]orkspace [S]ymbols"
        )

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("<leader>sh", vim.lsp.buf.signature_help, "[S]ignature [H]elp")

        map(
          "<leader>awf",
          vim.lsp.buf.add_workspace_folder,
          "[A]dd [W]orkspace [F]older"
        )

        map("<leader>o", function()
          vim.lsp.buf.format({ async = true })
        end, "F[o]rmat")

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        map("<leader>h", function()
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          else
            vim.notify(
              "Server is not an inlayhint provider",
              vim.log.levels.ERROR
            )
          end
        end, "Inlay [Hint]")

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
