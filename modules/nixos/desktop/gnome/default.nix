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
    home.extraOptions.dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
    ];
    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    services.gnome = {
      core-utilities.enable = true;
      core-shell.enable = true;
      core-os-services.enable = true;
    };
  };
}
