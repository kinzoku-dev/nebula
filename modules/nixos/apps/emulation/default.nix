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
    system.persist.home.dirs = [
      ".local/share/dolphin-emu"
      ".config/dolphin-emu"
      ".config/mgba"
      ".config/melonDS"
      ".config/rpcs3"
    ];

    apps.flatpak.packages = [
      "io.github.lime3ds.Lime3DS"
    ];
    environment.systemPackages = with pkgs; [
      melonDS
      mgba
      ryujinx
      mupen64plus
      rpcs3
      dolphin-emu
    ];
    # ++ (with inputs; [
    #   dolphin-emu-nix.packages.x86_64-linux.dolphin-emu
    # ]);
  };
}
