{
  config,
  pkgs,
  options,
  lib,
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
    apps.flatpak.packages = [
      "io.github.lime3ds.Lime3DS"
    ];
    environment.systemPackages = with pkgs; [
      melonDS
      mgba
      ryujinx
    ];
  };
}
