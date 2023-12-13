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
      package = pkgs.steam.override {
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
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      # gamescopeSession = {
      #   enable = true;
      # };
    };
    # programs.gamescope = {
    #   enable = true;
    # };
    environment.systemPackages = [
      pkgs.gamescope
      (pkgs.makeDesktopItem {
        name = "Steam (Gamepad UI)";
        desktopName = "Steam (Gamepad UI)";
        genericName = "Application for managing and playing games on Steam.";
        categories = ["Network" "FileTransfer" "Game"];
        type = "Application";
        icon = "steam";
        exec = "steamos";
        terminal = false;
      })

      (pkgs.writeShellScriptBin "steamos" ''
        gamescope -W 1920 -H 1080  -w 1920 -h 1080 -e --adaptive-sync -- steam -gamepadui -steamdeck -steamos -fulldesktopres -tenfoot
      '')
    ];

    home.programs.mangohud = {
      enable = true;
    };
  };
}
