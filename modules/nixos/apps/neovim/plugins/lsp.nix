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
            "<leader>la" = "code_action";
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
  };
}
