{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.nix;
in {
  options.apps.tools.nix = with types; {
    enable = mkBoolOpt false "enable some nix tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nix-index
      nix-init
      nix-update
      nixpkgs-fmt
    ];

    home.configFile."nix-init/config.toml".text = ''
      maintainers = ["kinzoku"]
      commit = true
    '';
  };
}
