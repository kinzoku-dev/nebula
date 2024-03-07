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
    system.persist.home.dirs = [
      ".config/vesktop"
      ".config/discord"
    ];
    environment.systemPackages = [
      (pkgs.vesktop.overrideAttrs {
        desktopItems = let
          mullvad-exclude = config.apps.mullvad-vpn.enable;
          disable-gpu = config.hardware.graphics.gpu == "nvidia";
        in [
          (pkgs.makeDesktopItem {
            name = "vesktop";
            desktopName = "Discord";
            exec = "${
              if mullvad-exclude
              then "mullvad-exclude"
              else ""
            } vesktop ${
              if disable-gpu
              then "--disable-gpu"
              else ""
            } --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo";
            icon = "discord";
            startupWMClass = "vesktop";
            genericName = "Internet Messenger";
            keywords = ["discord" "vencord" "electron" "chat"];
            categories = ["Network" "InstantMessaging" "Chat"];
          })
        ];
      })
    ];
    home.configFile."vesktop/themes/catppuccin.theme.css".source = ./catppuccin.theme.css;
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
