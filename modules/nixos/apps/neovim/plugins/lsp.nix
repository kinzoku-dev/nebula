{...}: {
  programs.nixvim = {
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
          };
          svelte.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
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
            "<leader>lj" = "goto_next";
            "<leader>lk" = "goto_prev";
            "<leader>lo" = "open_float";
          };
          lspBuf = {
            "<leader>lh" = "hover";
            "<leader>lr" = "references";
            "<leader>ld" = "definition";
            "<leader>li" = "implementation";
            "<leader>lt" = "type_definition";
            "<leader>ln" = "rename";
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
        beacon = {
          enable = true;
        };
        ui = {
          border = "rounded"; # One of none, single, double, rounded, solid, shadow
          codeAction = "💡"; # Can be any symbol you want 💡
        };
        hover = {
          openCmd = "!floorp"; # Choose your browser
          openLink = "gx";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        symbolInWinbar = {
          enable = true; # Breadcrumbs
        };
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = ["<Esc>" "q"];
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
            quit = ["<C-k>" "<Esc>"];
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
          scrollDown = "<C-f>";
          scrollUp = "<C-b>";
        };
      };
      which-key.registrations = {
        "<leader>l".name = " LSP";
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>la";
        action = "<cmd>Lspsaga code_action<CR>";
      }
    ];
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
