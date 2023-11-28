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
    apps.neovim.enable = true;
    apps.tools.direnv.enable = true;
    apps.yazi.enable = true;
    apps.tmux.enable = true;

    home.configFile."nix-init/config.toml".text = ''
      maintainers = ["kinzoku"]
      commit = true
    '';

    environment.systemPackages = with pkgs; [
      nix-index
      nix-init
      nix-update
      nixpkgs-fmt
      nixpkgs-review
    ];
  };
}
