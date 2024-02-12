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
      ((pkgs.discord-canary.override {withVencord = true;}).overrideAttrs {
        desktopItems = let
          mullvad-exclude = config.apps.mullvad-vpn.enable;
          disable-gpu = config.hardware.graphics.gpu == "nvidia";
        in [
          (pkgs.makeDesktopItem {
            name = "discordcanary";
            desktopName = "Discord Canary";
            exec = "${
              if mullvad-exclude
              then "mullvad-exlude"
              else ""
            } discordcanary ${
              if disable-gpu
              then "--disable-gpu"
              else ""
            }";
            icon = "discord-canary";
          })
        ];
      })
    ];
    home.configFile."Vencord/themes/catppuccin.theme.css".source = ./catppuccin.theme.css;
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
