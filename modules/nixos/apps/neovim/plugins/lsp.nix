{...}: {
  programs.nixvim = {
    keymaps = [
      {
        action = "function() vim.lsp.buf.hover() end";
        lua = true;
        key = "gh";
      }
      {
        action = "function() vim.lsp.buf.definition() end";
        lua = true;
        key = "gd";
      }
      {
        action = "function() vim.lsp.buf.code_action() end";
        lua = true;
        key = "<leader>ca";
      }
      {
        action = "function() vim.lsp.buf.rename() end";
        lua = true;
        key = "<leader>rn";
      }
      {
        action = "function() vim.lsp.buf.references() end";
        lua = true;
        key = "gr";
      }
      {
        action = "function() vim.lsp.buf.type_definition() end";
        lua = true;
        key = "gD";
      }
    ];
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          csharp-ls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          gdscript.enable = true;
          gopls.enable = true;
          html.enable = true;
          lua-ls.enable = true;
          nil_ls.enable = true;
          rust-analyzer = {
            installRustc = true;
            installCargo = true;
            enable = true;
            settings = {
              checkOnSave = true;
              check = {
                command = "clippy";
              };
              procMacro = {
                enable = true;
              };
            };
          };
          svelte.enable = true;
          tailwindcss.enable = true;
          tsserver = {
            enable = true;
            filetypes = [
              "javascript"
              "javascriptreact"
              "typescript"
              "typescriptreact"
            ];
            extraOptions = {
              settings = {
                javascript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                  };
                };
                typescript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                  };
                };
              };
            };
          };
          volar.enable = true;
          vuels.enable = true;
          java-language-server.enable = true;
          kotlin-language-server.enable = true;
          htmx.enable = true;
          nushell.enable = true;
          pyright.enable = true;
        };
        keymaps = {
          diagnostic = {
            "gj" = "goto_next";
            "gk" = "goto_prev";
            "<leader>lo" = "open_float";
          };
        };
      };
      lsp-format = {
        enable = true;
      };
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      which-key.registrations = {
        "<leader>l".name = " LSP";
      };
    };
    extraConfigLua = ''
          local _border = "rounded"

          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                  vim.lsp.handlers.hover, {
                  border = _border
                  }
                  )

          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                  vim.lsp.handlers.signature_help, {
                  border = _border
                  }
                  )

          vim.diagnostic.config{
              float={border=_border}
          };

      require('lspconfig.ui.windows').default_options = {
          border = _border
      }
    '';
  };
}
