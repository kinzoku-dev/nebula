{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.gnome;
in {
  options.desktop.gnome = with types; {
    enable = mkBoolOpt false "Enable gnome";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;
  };
}
