{
  inputs,
  pkgs,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;

  modules = [
    (
      { pkgs, ... }:
      {
        packages = with pkgs; [
          age
          sops
          cachix
          deadnix
          statix
          nixd
          cargo-edit
        ];

        dotenv.enable = true;

        languages.rust = {
          enable = true;
        };
      }
    )
  ];
}
