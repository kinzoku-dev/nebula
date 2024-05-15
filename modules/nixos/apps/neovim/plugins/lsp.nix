{...}: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Lspsaga hover_doc<CR>";
        key = "gh";
      }
      {
        action = "<cmd>Lspsaga finder def<CR>";
        key = "gd";
      }
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ca";
      }
      {
        action = "<cmd>Lspsaga rename<CR>";
        key = "<leader>rn";
      }
      {
        action = "<cmd>Lspsaga finder ref<CR>";
        key = "gr";
      }
      {
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        key = "gD";
      }
      {
        action = "<cmd>Lspsaga outline<CR>";
        key = "go";
      }
      {
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        key = "gl";
      }
      {
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        key = "glj";
      }
      {
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        key = "glk";
      }
    ];
    plugins = {
      helm.enable = true;
      lsp = {
        enable = true;
        servers = {
          ansiblels.enable = true;
          bashls.enable = true;
          yamlls = {
            enable = true;
          };
          helm-ls.enable = true;
          terraformls.enable = true;
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
              diagnostics = {
                disabled = ["unlinked-file"];
              };
              completion = {
                privateEditable.enable = true;
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
          htmx = {
            enable = true;
            filetypes = [
              "html"
              "htmldjango"
              "typescriptreact"
              "javascriptreact"
            ];
          };
          nushell.enable = true;
          pyright.enable = true;
        };
        keymaps = {
          diagnostic = {
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
      lspsaga = {
        enable = true;
        beacon.enable = true;
        ui = {
          border = "rounded";
          codeAction = "💡";
        };
        hover = {
          openCmd = "!firefox";
          openLink = "gx";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = [
              "<Esc>"
              "q"
            ];
          };
        };
        lightbulb = {
          enable = false;
          sign = false;
          virtualText = true;
        };
        implement = {
          enable = false;
        };
        rename = {
          autoSave = false;
          keys = {
            exec = "<CR>";
            quit = [
              "<C-x>"
              "<Esc>"
            ];
            select = "x";
          };
        };
        outline = {
          autoClose = true;
          autoPreview = true;
          closeAfterJump = true;
          layout = "normal"; # normal or float
          winPosition = "right"; # left or right
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };
        scrollPreview = {
          scrollDown = "<C-j>";
          scrollUp = "<C-k>";
        };
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

      require('lspconfig').yamlls.setup({
        settings = {
          yaml = {
            schemas = {
              kubernetes = "*.yaml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "{kustomization,ks}.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
            },
          }
        }
      })
    '';
  };
}
