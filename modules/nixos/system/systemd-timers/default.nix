{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.systemd-timers;
in {
  options.system.systemd-timers = with types; {
    enable = mkBoolOpt false "Enable systemd-timers";
  };

  config = mkIf cfg.enable {
    systemd.timers."wallpaper" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "wallpaper.service";
      };
    };

    systemd.services."wallpaper" = {
      script = ''
        export XDG_RUNTIME_DIR=/run/user/1000
        ${pkgs.custom.wallpaper}/bin/wallpaper
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
  };
}
