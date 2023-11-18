{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.flatpak;
in {
  options.apps.flatpak = with types; {
    enable = mkBoolOpt false "enable flatpak";
  };

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      packages = [
        "im.riot.Riot"
      ];
    };
  };
}
