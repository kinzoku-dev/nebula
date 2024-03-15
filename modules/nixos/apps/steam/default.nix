{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.steam;
in {
  options.apps.steam = with types; {
    enable = mkBoolOpt false "Enable or disable steam gaming platform";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      package =
        (pkgs.steam.override
          {
            extraPkgs = pkgs:
              with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
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
              keywords = ["call" "signal" "electron" "chat"];
              categories = ["Network" "InstantMessaging" "Chat"];
            })
          ];
        };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    system.persist.home.dirs = [
      ".local/share/Steam"
    ];
    environment.systemPackages = [
      pkgs.protonup-ng
      pkgs.gamescope
      pkgs.mangohud
      pkgs.goverlay
    ];
  };
}
