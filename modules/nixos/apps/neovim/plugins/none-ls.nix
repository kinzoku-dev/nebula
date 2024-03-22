{pkgs, ...}: {
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      updateInInsert = false;
      sources = {
        code_actions = {
          refactoring.enable = true;
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
          fish.enable = true;
          yamllint.enable = true;
        };
        formatting = {
          csharpier.enable = true;
          prettier.enable = true;
          gdformat.enable = true;
          gofumpt.enable = true;
          stylua.enable = true;
          leptosfmt.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          yamlfmt.enable = true;
          black = {
            enable = true;
            withArgs = ''
              {
                  extra_args = { "--fast" },
              }
            '';
          };
        };
      };
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>lf";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "LSP format";
        };
      }
    ];
  };
}
