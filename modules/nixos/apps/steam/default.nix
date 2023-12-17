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
    };

    environment.systemPackages = [
      pkgs.gamescope
    ];

    home.programs.mangohud = {
      enable = true;
    };
  };
}
