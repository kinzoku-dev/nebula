{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.picom;
in {
  options.desktop.picom = with types; {
    enable = mkBoolOpt false "Enable picom X11 compositor";
  };

  config = mkIf cfg.enable {
    home.extraOptions.services.picom = {
      enable = true;
      activeOpacity = 0.95;
      inactiveOpacity = 0.95;
      settings = {
        blur = {
          mething = "gaussian";
          size = 10;
          deviation = 5.0;
        };
      };
    };
  };
}
