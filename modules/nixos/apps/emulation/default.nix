{
  config,
  pkgs,
  options,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.emulation;
in {
  options.apps.emulation = with types; {
    enable = mkBoolOpt false "Enable game emulation apps";
  };

  config = mkIf cfg.enable {
    environment = {
      persist.home.directories = [
        ".local/share/dolphin-emu"
        ".config/dolphin-emu"
        ".config/mgba"
        ".config/melonDS"
        ".config/rpcs3"
        ".config/Cemu"
        ".local/share/Cemu"
      ];
      systemPackages = with pkgs; [
        melonDS
        mgba
        ryujinx
        mupen64plus
        rpcs3
        pcsx2
        duckstation
        cemu
        xwiimote
      ];
    };

    apps.flatpak.packages = [
      "io.github.lime3ds.Lime3DS"
    ];
    hardware.uinput.enable = true;
    services.udev.packages = [
      pkgs.game-devices-udev-rules
    ];
    # ++ (with inputs; [
    #   dolphin-emu-nix.packages.x86_64-linux.dolphin-emu
    # ]);
  };
}
