{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.polybar;
in {
  options.desktop.polybar = with types; {
    enable = mkBoolOpt false "Enable polybar";
  };

  config = mkIf cfg.enable {
    home.extraOptions.services.polybar = {
      enable = true;
      package = pkgs.polybarFull;
      config = ./config.ini;
      script = "polybar top &";
    };
    fonts.packages = [
      pkgs.font-awesome
    ];
  };
}
