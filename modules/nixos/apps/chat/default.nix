{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.chat;
in {
  options.apps.chat = with types; {
    enable = mkBoolOpt false "Enable chat apps";
  };

  config = mkIf cfg.enable {
    system.persist.home.dirs = [
      ".config/Signal Beta"
    ];
    environment.systemPackages = with pkgs; [
      revolt-desktop
      dino
      mumble
      cinny-desktop
      element-desktop
      telegram-desktop
      (signal-desktop-beta.overrideAttrs {
        desktopItems = [
          (makeDesktopItem {
            name = "signal";
            desktopName = "Signal";
            exec = "signal-desktop-beta --disable-gpu %U";
            icon = "signal";
            startupWMClass = "Signal Beta";
            genericName = "Internet Messenger";
            keywords = ["call" "signal" "electron" "chat"];
            categories = ["Network" "InstantMessaging" "Chat"];
          })
        ];
      })
    ];
  };
}
