{pkgs, ...}:
with pkgs;
  mkShell {
    nativeBuildInputs = [
      treefmt

      alejandra
      shfmt

      go
      gofumpt
      gopls

      pkg-config
      glib
    ];
  }
