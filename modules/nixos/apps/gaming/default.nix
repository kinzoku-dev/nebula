{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.gaming;
in {
  options.apps.gaming = with types; {
    enable = mkBoolOpt false "Enable gaming module";
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        package =
          (pkgs.steam.override {
            extraPkgs = pkgs:
              with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                libGL
                stdenv.cc.cc.lib
                libkrb5
                keyutils
                libgdiplus
                at-spi2-atk
                fmodex
                gtk3
                gtk3-x11
                harfbuzz
                icu
                glxinfo
                inetutils
                libthai
                mono5
                pango
                strace
                zlib
                iconv
                libunwind
              ];
          })
          .overrideAttrs
          {
            desktopItems = [
              (pkgs.makeDesktopItem {
                name = "Steam";
                desktopName = "Steam";
                exec = "${lib.optionalString config.apps.mullvad-vpn.enable "mullvad-exclude"} ${lib.optionalString config.hardware.graphics.nvidiaOffload.enable "prime-run"} steam";
                icon = "steam";
                startupWMClass = "Signal Beta";
                genericName = "Internet Messenger";
                keywords = [
                  "call"
                  "signal"
                  "electron"
                  "chat"
                ];
                categories = [
                  "Network"
                  "InstantMessaging"
                  "Chat"
                ];
              })
            ];
          };
        # remotePlay.openFirewall = true;
        # dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };

      gamemode.enable = true;
    };
    system.persist.home.dirs = [
      ".local/share/Steam"
      ".local/share/Terraria"
    ];
    environment = {
      systemPackages = with pkgs; [
        protonup
        mangohud
        goverlay
        lutris
        heroic
        bottles
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${config.user.name}/.steam/root/compatibilitytools.d";
      };
    };
  };
}
