{pkgs, ...}:
with pkgs;
  mkShell {
    nativeBuildInputs = [
      treefmt

      alejandra
      python310Packages.mdformat
      shfmt
    ];
  }
