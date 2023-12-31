{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.calcure;
in {
  options.apps.calcure = with types; {
    enable = mkBoolOpt false "Enable calcure";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      calcure
      (makeDesktopItem {
        name = "Calcure";
        desktopName = "Calcure";
        genericName = "Terminal calendar app";
        categories = [];
        type = "Application";
        icon = "calendar";
        exec = "kitty calcure";
      })
    ];
  };
}
