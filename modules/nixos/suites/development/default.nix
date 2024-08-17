{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.suites.development;
in {
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable development suite";
  };

  config = mkIf cfg.enable {
    apps = {
      neovim.enable = true;
      tools.direnv.enable = true;
      yazi.enable = true;
      tmux.enable = true;
      jetbrains.enable = true;
    };

    home.configFile."nix-init/config.toml".text = ''
      maintainers = ["kinzoku"]
      commit = true
    '';

    environment.systemPackages = with pkgs; [
      nix-init
      nix-update
      nixpkgs-review

      (fenix.combine [
        (fenix.complete.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
        fenix.targets.wasm32-unknown-unknown.latest.rust-std
      ])
      # rust-analyzer-nightly

      bun
      nodePackages_latest.npm
      nodePackages_latest.pnpm
    ];
  };
}
