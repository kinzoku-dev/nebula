{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.discord;
in {
  options.apps.discord = with types; {
    enable = mkBoolOpt false "Enable or disable discord";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.vesktop.overrideAttrs {
        desktopItems = let
          mullvad-exclude = config.apps.mullvad-vpn.enable;
          disable-gpu = config.hardware.graphics.gpu == "nvidia";
        in [
          (pkgs.makeDesktopItem {
            name = "vencorddesktop";
            desktopName = "Discord";
            exec = "${
              if mullvad-exclude
              then "mullvad-exlude"
              else ""
            } vencorddesktop ${
              if disable-gpu
              then "--disable-gpu"
              else ""
            }";
            icon = "discord";
            startupWMClass = "VencordDesktop";
            genericName = "Internet Messenger";
            keywords = ["discord" "vencord" "electron" "chat"];
            categories = ["Network" "InstantMessaging" "Chat"];
          })
        ];
      })
    ];
    home.file.".config/VencordDesktop/VencordDesktop/themes/catppuccin.theme.css".source = ./catppuccin.theme.css;
    home.configFile."discord/settings.json".text = ''
      {
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "OPEN_ON_STARTUP": false,
        "MINIMIZE_TO_TRAY": false,
        "SKIP_HOST_UPDATE": true
      }
    '';
  };
}
