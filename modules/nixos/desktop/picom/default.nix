{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.picom;
in {
  options.desktop.picom = with types; {
    enable = mkBoolOpt false "Enable picom X11 compositor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.picom-allusive
    ];

    home.configFile."picom/picom.conf".text = ''
      opacity-rule = [
        "100:fullscreen",
        "100:name *= 'Brave'",
        "100:name *= 'Discord'",
        "100:name *= 'Steam'",
        "100:name *= 'Spotify'",
        "100:class_g = 'Element'",
        "100:name *= 'LibreWolf'",
      ];

      corner-radius = 12;
      corners-rule = [
        "12:name = 'xmobar'"
      ];

      animations = false;

      inactive-opacity = 0.95;
      active-opacity = 0.95;

      backend = "glx";
    '';
  };
}
