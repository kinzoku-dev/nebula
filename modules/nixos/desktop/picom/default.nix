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
    environment.systemPackages = [
      pkgs.picom
    ];

    home.configFile."picom/picom.conf".text = ''
      opacity-rule = [
        "100:fullscreen",
        "100:name *= 'Brave'",
        "100:name *= 'Discord'",
        "100:name *= 'Steam'"
      ];

      inactive-opacity = 0.95;
      active-opacity = 0.95;
    '';
  };
}
