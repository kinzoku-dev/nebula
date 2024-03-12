{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.mullvad-vpn;
in {
  options.apps.mullvad-vpn = with types; {
    enable = mkBoolOpt false "Enable mullvad vpn";
  };

  config = mkIf cfg.enable {
    system.persist.home.dirs = [
      ".config/Mullvad VPN"
    ];
    environment.systemPackages = [
      pkgs.mullvad-vpn
      (pkgs.makeDesktopItem {
        name = "Mullvad GUI";
        desktopName = "Mullvad GUI";
        genericName = "Application for managing Mullvad VPN connection";
        categories = ["Network"];
        type = "Application";
        icon = "mullvad";
        exec = "mullvad-gui";
        terminal = false;
      })
    ];

    services.mullvad-vpn.enable = true;
  };
}
