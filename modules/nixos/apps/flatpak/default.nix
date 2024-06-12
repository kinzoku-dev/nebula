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
    packages = mkOpt (listOf str) [] "Flatpaks to install";
  };

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      inherit (cfg) packages;
    };
    system.persist.home.dirs = [
      ".var/app"
      ".local/share/flatpak"
    ];
  };
}
