{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.printing;
in {
  options.apps.printing = with types; {
    enable = mkBoolOpt false "Enable 3d printing software";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      printrun
      super-slicer
    ];
  };
}
