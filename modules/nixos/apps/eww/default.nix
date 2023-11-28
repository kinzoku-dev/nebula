{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.eww;
in {
  options.apps.eww = with types; {
    enable = mkBoolOpt false "Enable ElkoWar's Wacky Widgets";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.eww-wayland
    ];

    home.configFile."eww/eww.yuck" = {
      source = ./yuck/eww.yuck;
    };
  };
}
